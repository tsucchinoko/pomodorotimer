//
//  TimerModel.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/22.
//

import Foundation
import SwiftUI
import AVFoundation
import UserNotifications

// MARK: - TIMER_MODEL
class TimerModel:ObservableObject {
    
    //Pickerで設定した分を格納
    @Published var minSelection: Int = 0
    //Pickerで設定した秒を格納
    @Published var restMinSelection: Int = 0
    //Pickerで設定したセット回数を格納
    @Published var countSelection: Int = 0
    
    //カウントダウン残り時間
    @Published var duration: Float = 0.0
    //カウントダウン開始前の最大時間
    @Published var maxValue: Float = 0.0
    
    // セット回数
    @Published var count: Int = 0
    
    // 集中タイム or 休憩タイムの表示
    @Published var doingStatus: String = "集中タイム"
    
    //タイマーのステータス
    @Published var timerStatus: TimerStatus = .stopping
    
    @Published var beforePausingStatus: TimerStatus = .pomoroding
    
    //サウンドID
    @Published var soundID: SystemSoundID = 1151
    
    //BGM音のOn/Off
    @Published var isBGMOn: Bool = true
    
    @Published var isRestBGMOn: Bool = true
    //バイブレーションのOn/Off
    @Published var isVibrationOn: Bool = true
    
    // 入室中
    @Published var isEntering: Bool = false
    
    // ポモドーロ中
    @Published var isDoing: Bool = false
    
    // 終了画面のモーダル表示
    @Published var isFinished: Bool = false
    // 設定画面のモーダル表示
    @Published var isSetting: Bool = false
    
    @Published var timer: Timer!
    
    var audioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer!
    var room: Room = roomData[0]
    var granted: Bool = false
    
    func startTimer() {

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true){ _ in
            self.advancedTimer(room: self.room)
        }
        
    }
    
    
    func setTimer(room: Room) {
        if timerStatus == .pomoroding {
            duration = Float((minSelection + 1) * 60)
        } else {
            duration = Float((restMinSelection + 1) * 60)
        }
        
        maxValue = duration
    }
    
    
    func playSound(bgmName: String) {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            print("Failed to set audio session category.")
        }

        guard isBGMOn else { return }
        
        guard let url = Bundle.main.url(forResource: bgmName, withExtension: "mp3") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        audioPlayer = try? AVAudioPlayer(data: data)
        audioPlayer?.currentTime = 0
        audioPlayer?.volume = 0.0
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
        audioPlayer?.setVolume(0.5, fadeDuration: 5.0)
    }
    
    func displayTimer() -> String {
        let min = Int(duration) % 3600 / 60
        let sec = Int(duration) % 3600 % 60

        return String(format: "%02d:%02d", min, sec)
    }
    
    func displayStatus() {
        if timerStatus == .pomoroding {
            doingStatus = "集中タイム"
        } else if timerStatus == .resting {
            doingStatus = "休憩タイム"
        } else {
            if beforePausingStatus == .pomoroding {
                doingStatus = "集中タイム"
            } else {
                doingStatus = "休憩タイム"
            }
        }
    }
    
    func showSettingsView() {
        isSetting = true
    }
    
    func hideSettingsView(isBGMOn: Bool, isVibrationOn: Bool) {
        isSetting = false
        self.isBGMOn = isBGMOn
        self.isVibrationOn = isVibrationOn
    }
    
    func setCount()  {
        self.count = countSelection
    }
    
    func pomodoro() {
        audioPlayer?.stop()
        
        timerStatus = .pomoroding
        playSound(bgmName: room.bgm)
    }
    
    func restartPomodoro() {
        timerStatus = .pomoroding
        let timeOffset = audioPlayer.deviceCurrentTime + 0.01
        
        guard isBGMOn else { return }
        audioPlayer?.play(atTime: timeOffset)
    }
    
    func rest() {
        audioPlayer?.stop()
        
        timerStatus = .resting
        playSound(bgmName: "rest")
    }
    
    func restartResting() {
        timerStatus = .resting
        let timeOffset = audioPlayer.deviceCurrentTime + 0.01
        
        guard isBGMOn else { return }
        audioPlayer?.play(atTime: timeOffset)
    }
    
    func pause() {
        timerStatus = .pausing
        audioPlayer?.pause()
    }
    
    func restart(beforePausingStatus: TimerStatus) {
        if beforePausingStatus == .pomoroding {
            restartPomodoro()
        } else if beforePausingStatus == .resting {
            restartResting()
        }
    }
    
    func stop() {
        timerStatus = .stopping
        duration = 0
        maxValue = 0
        minSelection = 0
        restMinSelection = 0
        countSelection = 0
        count = 0
        
        isDoing = false
        audioPlayer?.stop()
        
        timer?.invalidate()
        timer = nil
    }
    
    func advancedTimer(room: Room) {
        //タイマーステータスが.running以外の場合何も実行しない
        guard timerStatus == .pomoroding || timerStatus == .resting else { return }
        
        //残り時間が0より大きい場合
        if duration > 0 {
            //残り時間から -0.05 する
            duration -= 0.05
            print(duration)
            
            // 残り時間が5秒以下ならフェードアウト
            if duration < 5 {
                audioPlayer?.setVolume(0, fadeDuration: 5.0)
            }
//            print("duration: \(duration)")
            //残り時間が0以下の場合
        } else {
            zeroTimeAction()
        }
    }
    
    func zeroTimeAction() {
        switch timerStatus {
            case .pomoroding:
                rest()
                setTimer(room: room)
                displayStatus()
            case .resting:
                if count < countSelection {
                    //タイマーステータスを.pomorodingに変更する
                    pomodoro()
                    setTimer(room: room)
                    displayStatus()
                    count += 1
                } else {
                    //タイマーステータスを.stoppimgに変更する
                    isFinished = true
                    stop()
                    
                    guard isVibrationOn else { return }
                    //アラーム音を鳴らす
                    AudioServicesPlayAlertSoundWithCompletion(soundID, nil)
                    //バイブレーションを作動させる
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                    
                    guard granted else { return }
                    makeNotification()
                }
            default:
                return
        }
    }
    
    
    //①通知関係のメソッド作成
   func makeNotification(){
        //②通知タイミングを指定
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)

        //③通知コンテンツの作成
        let content = UNMutableNotificationContent()
        content.title = "終了！"
        content.body = "よく頑張りました！"
        content.sound = UNNotificationSound.default

        //④通知タイミングと通知内容をまとめてリクエストを作成。
        let request = UNNotificationRequest(identifier: "notification001", content: content, trigger: trigger)

        //⑤④のリクエストの通りに通知を実行させる
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
}
