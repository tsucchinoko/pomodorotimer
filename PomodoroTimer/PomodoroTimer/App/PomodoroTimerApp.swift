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
}
