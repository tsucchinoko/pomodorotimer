//
//  StopButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/27.
//

import SwiftUI

struct StopButtonView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    
    // MARK: - BODY
    var body: some View {
        Button(action: {
            self.timerModel.stop()
        }) {
            HStack(spacing: 8) {
                Text("終了")
                    .font(.system(.title3, design: .monospaced))
            }//: HSTACK
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
        }//: BUTTON
        .accentColor(Color.white)
    }
}

struct StopButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StopButtonView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
