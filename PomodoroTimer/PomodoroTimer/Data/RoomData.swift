//
//  RoomData.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/25.
//

import SwiftUI

//var roomName: String
//var timer: TimerModel
//var bgm: String
//var bgColor: [Color]
// MARK: - ROOM MODEL DATA
let roomData: [Room] = [
    Room(roomName: "森の部屋", bgm: "forest", gradientColors: [Color("ColorForestLight"), Color("ColorForestDark")]),
    Room(roomName: "海の部屋", bgm: "sea", gradientColors: [Color("ColorSeaLight"), Color("ColorSeaDark")]),
    Room(roomName: "ロウリュウの部屋", bgm: "fire", gradientColors: [Color("ColorFireLight"), Color("ColorFireDark")]),
//    TODO 追加
//    Room(roomName: "星の部屋", bgm: "星", gradientColors: [Color("ColorCosmoLight"), Color("ColorCosmoDark")]),
//    Room(roomName: "カフェの部屋", bgm: "コーヒー", gradientColors: [Color("ColorCoffeeLight"), Color("ColorCoffeeDark")])
]
