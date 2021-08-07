//
//  PomodoroView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/27.
//

import SwiftUI

struct PomodoroView: View {
    // MARK: - PROPERTIES
    //モーダルシートを利用するためのプロパティ
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timerModel: TimerModel
    var room: Room
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            BGColorView(room: room)
            VStack {
                Text(room.roomName)
                    .fontWeight(.bold)
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                ZStack {
                    ProgressBarView()
                    TimeView()
                }//: ZSTACK
                
                VStack {
                    Text("\(timerModel.doingStatus)")
                    Divider()
                    Text("\(timerModel.count + 1 ) / \(timerModel.countSelection + 1)セット")
                }//: VSTACK
                .font(.system(.title, design: .monospaced))
                .foregroundColor(.white)
                .fixedSize()
                
                HStack {
                    StopButtonView()
                        .padding(.vertical, 40)
                        .padding(.horizontal, 20)
                        .font(.title)
                    
                    if timerModel.timerStatus == .pausing {
                        restartButtonView()
                            .padding(.vertical, 40)
                            .padding(.horizontal, 20)
                            .font(.title)
                    } else {
                        PauseButtonView()
                            .padding(.vertical, 40)
                            .padding(.horizontal, 20)
                            .font(.title)
                    }
                }
            }//: VSTACK
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        }
        
    }//: BODY
}


// MARK: - PREVIEW
//struct PomodoroView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            PomodoroView(room: roomData[0]).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
////            PomodoroView(room: roomData[1]).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
////            PomodoroView(room: roomData[2])
////            PomodoroView(room: roomData[3])
//        }.environmentObject(TimerModel())
//    }
//}
