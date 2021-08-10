//
//  TimerModel.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/22.
//

import Foundation
import SwiftUI
import AVFoundation

// MARK: - TIMER_MODEL
class TimerModel:ObservableObject {
    
    //Pickerで設定した分を格納
    @Published var minSelection: Int = 0
    //Pickerで設定した秒を格納
    @Published var restMinSelection: Int = 0
    //Pickerで設定したセット回数を格納
    @Published var countSelection: Int = 0
    
    //カウントダウン残り時間
    @Published var duration: Double = 0.0
    //カウントダウン開始前の最大時間
    @Published var maxValue: Double = 0.0
    
    // セット回数
    @Published var count: Int = 0
    
    // 集中タイム or 休憩タイムの表示
    @Published var doingStatus: String = "集中タイム"
    
    //タイマーのステータス
    @Published var timerStatus: TimerStatus = .stopping
    @Published var beforePausingStatus: TimerStatus = .pomoroding
    
    //サウンドID
    @Published var soundID: SystemSoundID = 1151

    //アラーム名
    @Published var soundName: String = "Beat"
    
    
    
    //音のOn/Off
    @Published var isBGMOn: Bool = true
    
    @Published var isRestBGMOn: Bool = true
    //バイブレーションのOn/Off
    @Published var isVibrationOn: Bool = true
    //プログレスバー表示のOn/Off
    @Published var isProgressBarOn: Bool = true
    //エフェクトアニメーションのOn/Off
    @Published var isEffectAnimationOn: Bool = true
    
    // 入室
    @Published var isEntering: Bool = false
    
    // ポモドーロ中
    @Published var isDoing: Bool = false
    
    @Published var isFinished: Bool = false
    //モーダル表示
    @Published var isSetting: Bool = false
    
    @Published var timer: Timer!
    
    //1秒ごとに発動するタイマークラスのパブリッシュメソッド
//    var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var audioSession = AVAudioSession.sharedInstance()
    
//    var backgroundTaskId = UIBackgroundTaskIdentifier.init(rawValue: 0)
    
    var audioPlayer: AVAudioPlayer!
    var room: Room = roomData[0]
    
    func startTimer() {
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true){ _ in
            self.advancedTimer(room: self.room)
        }
        RunLoop.current.add(timer, forMode: .common)
        
    }
    
    
    func setTimer(room: Room) {
        if timerStatus == .pomoroding {
            duration = Double((minSelection + 1) * 60)
        } else {
            duration = Double((restMinSelection + 1) * 60)
        }
        
        maxValue = duration
//        self.backgroundTaskId = UIApplication.shared.beginBackgroundTask(expirationHandler: nil)
    }
    
    
    func playSound(bgmName: String) {
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            print("Failed to set audio session category.")
        }

        guard let url = Bundle.main.url(forResource: bgmName, withExtension: "mp3") else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        audioPlayer = try? AVAudioPlayer(data: data)
        audioPlayer?.prepareToPlay()
        audioPlayer?.volume = 1.0
        audioPlayer?.numberOfLoops = -1
        audioPlayer?.play()
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
    
    func hideSettingsView() {
        isSetting = false
    }
    
    func setCount()  {
        self.count = countSelection
    }
    
    func pomodoro() {
        audioPlayer?.stop()
        
        timerStatus = .pomoroding
        playSound(bgmName: room.bgm)
        audioPlayer?.play()
    }
    
    func restartPomodoro() {
        timerStatus = .pomoroding
        let timeOffset = audioPlayer.deviceCurrentTime + 0.01
        audioPlayer?.play(atTime: timeOffset)
    }
    
    func rest() {
        audioPlayer?.stop()
        
        timerStatus = .resting
        playSound(bgmName: "rest")
        audioPlayer?.play()
    }
    
    func restartResting() {
        timerStatus = .resting
        
        let timeOffset = audioPlayer.deviceCurrentTime + 0.01
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
        self.timer?.invalidate()
        timer = nil
        self.duration = 0
        isDoing = false
        audioPlayer?.stop()
//        UIApplication.shared.endBackgroundTask(self.backgroundTaskId)
    }
    
    func advancedTimer(room: Room) {
        //タイマーステータスが.running以外の場合何も実行しない
        guard timerStatus == .pomoroding || timerStatus == .resting else { return }
        
        //残り時間が0より大きい場合
        if duration > 0 {
            //残り時間から -0.05 する
            duration -= 0.05
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
                    //アラーム音を鳴らす
                    AudioServicesPlayAlertSoundWithCompletion(soundID, nil)
                    //バイブレーションを作動させる
                    AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
                }
            default:
                return
        }
    }
}
