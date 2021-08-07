//
//  PomodoroTimerApp.swift
//  PomodoroTimer WatchKit Extension
//
//  Created by Daichi Tsuchiya on 2021/07/22.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
