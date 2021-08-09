//
//  TimerView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/25.
//

import SwiftUI

struct TimerView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var isAnimating: Bool = false
    var room: Room
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            BGColorView(room: room)
            VStack {
                if timerModel.isFinished {
                    FinishPomodoroView(room: room)
                        .environmentObject(timerModel)
                } else {
                        HStack {
                            BackButtonView()
                                .padding()
                            Spacer()
                            SettingsButtonView()
                                .padding()
                        }// HStack
                       
                    // TEXT: ROOM NAME
                    Text(room.roomName)
                        .fontWeight(.bold)
                        .font(.system(.title, design: .monospaced))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                        .padding()
                    Spacer()
                    // PICKER:
                    PickerView()
                    Spacer()
                    // BUTTON: START BUTTON
                    StartButtonView(room: room)
                        .padding(.bottom, 40)
                        .font(.system(.title, design: .monospaced))
                }//: else
            }//: VSTACK
            .sheet(isPresented: $timerModel.isSetting, content: {
                SettingsView().environmentObject(timerModel)
            })
            .fullScreenCover(isPresented: $timerModel.isDoing) {
                PomodoroView(room: room)
                    .environmentObject(timerModel)
             }//: FULL SCREEN COVER
        }//: ZSTACK
        .navigationBarHidden(true)
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)

        //指定した時間（1秒）ごとに発動するtimerをトリガーにしてクロージャ内のコードを実行
        .onReceive(self.timerModel.timer) { _ in
            timerModel.advancedTimer(room: room)
        }//: onReceive
        .onAppear {
                isAnimating = true
        }//: onAppear
    }//: BODY
}


// MARK: - PREVIEW
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimerView(room: roomData[2]).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//            TimerView(room: roomData[1]).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//            TimerView(room: roomData[2])
//            TimerView(room: roomData[3])
        }.environmentObject(TimerModel())
    }
}
