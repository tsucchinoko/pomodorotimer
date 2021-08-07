//
//  RoomModel.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/25.
//

import SwiftUI

// MARK: - ROOM MODEL
struct Room: Identifiable {
    var id = UUID()
    var roomName: String
//    var timer: TimerModel
    var bgm: String
    var gradientColors: [Color]
}

