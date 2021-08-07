//
//  PauseButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/28.
//

import SwiftUI

struct PauseButtonView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    
    // MARK: - BODY
    var body: some View {
        Button(action: {
            self.timerModel.beforePausingStatus = timerModel.timerStatus
            self.timerModel.pause()
            self.timerModel.displayStatus()
        }) {
            HStack(spacing: 8) {
                Text("停止")
                    .font(.system(.title3, design: .monospaced))
            }//: HSTACK
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
        }//: BUTTON
        .accentColor(Color.white)
    }//: BODY
}

struct PauseButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PauseButtonView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
