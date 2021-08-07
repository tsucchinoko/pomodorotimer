//
//  RoomCardView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/25.
//

import SwiftUI

struct RoomCardView: View {
    
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    @State private var isAnimating: Bool = false
    var room: Room
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            BGColorView(room: room)
            VStack {
                //TEXT: ROOM NAME
                Text(room.roomName)
                    .fontWeight(.bold)
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.vertical, 100)
                

                    //BUTTON: ENTERING
                    EnteringButtonView(room: room)
                        .font(.system(.title2, design: .monospaced))
            }
                
        }//: ZSTACK
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        .cornerRadius(20.0)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        

    }//: BODY
    
    
}


// MARK: - PREVIEW
//struct RoomCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        
//        Group {
//            RoomCardView(room: roomData[0]).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//            RoomCardView(room: roomData[1]).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//            RoomCardView(room: roomData[2])
//            RoomCardView(room: roomData[3])
//        }.environmentObject(TimerModel())
//    }
//}
