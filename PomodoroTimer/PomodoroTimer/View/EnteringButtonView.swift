//
//  EnteringButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/26.
//

import SwiftUI

struct EnteringButtonView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    var room: Room
    // MARK: - BODY
    var body: some View {
        NavigationLink(
            destination: TimerView(room: room),
            isActive: self.$timerModel.isEntering
        ) {
            Button(action: {
                self.timerModel.isEntering = true
            }) {
                HStack(spacing: 8) {
                    Text("入室")
                        .font(.system(.title3, design: .monospaced))
                    Image(systemName: "arrow.right.circle")
                        .imageScale(.large)
                }//: HSTACK
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Capsule().strokeBorder(Color.white, lineWidth: 1.25))
            }//: BUTTON
            .accentColor(Color.white)
        }//: NAV LINK
    }
}

// MARK: - PREVIEW
struct EnteringButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EnteringButtonView(room: roomData[0])
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .environmentObject(TimerModel())
    }
}
