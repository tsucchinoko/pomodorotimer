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
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Get the singleton instance.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            // Set the audio session category, mode, and options.
            try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
        } catch {
            print("Failed to set audio session category.")
        }
        
        // Other post-launch configuration.
        return true
    }


}
