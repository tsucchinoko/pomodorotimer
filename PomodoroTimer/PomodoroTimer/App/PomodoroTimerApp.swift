//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/22.
//

import SwiftUI
import AVFoundation

@main
struct PomodoroTimerApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(TimerModel())
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default)
        } catch {
            fatalError("Cateogry設定失敗")
        }

        do {
            try session.setActive(true)
        } catch {
            fatalError("Session失敗")
        }

        return true
    }


}
