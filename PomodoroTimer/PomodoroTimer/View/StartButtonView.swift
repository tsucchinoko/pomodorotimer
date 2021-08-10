//
//  StartButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/26.
//

import SwiftUI

struct StartButtonView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    var room: Room
    
    // MARK: - BODY
    var body: some View {
        Button(action: {
            self.timerModel.room = room
            self.timerModel.pomodoro()
            self.timerModel.setTimer(room: room)
            self.timerModel.startTimer()
            self.timerModel.displayStatus()
            self.timerModel.isDoing = true
        }) {
            HStack(spacing: 8) {
                Text("開始")
                    .font(.system(.title3, design: .monospaced))
            }//: HSTACK
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
        }//: BUTTON
        .accentColor(Color.white)
    }
}


// MARK: - PREVIEW
struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView(room: roomData[0])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
