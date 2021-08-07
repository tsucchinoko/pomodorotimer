//
//  restartButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/28.
//

import SwiftUI

struct restartButtonView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    
    // MARK: - BODY
    var body: some View {
        Button(action: {
            self.timerModel.restart(beforePausingStatus: timerModel.beforePausingStatus)
            self.timerModel.displayStatus()
        }) {
            HStack(spacing: 8) {
                Text("再開")
                    .font(.system(.title3, design: .monospaced))
            }//: HSTACK
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
        }//: BUTTON
        .accentColor(Color.white)
    }//: BODY
}

struct restartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        restartButtonView()
    }
}
