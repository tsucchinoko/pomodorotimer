//
//  SoundModel.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/30.
//

import SwiftUI
import AudioToolbox

struct Sound: Identifiable {
    let id: SystemSoundID
    let soundName: String
}
