//
//  FinishPomorodoView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/29.
//

import SwiftUI

struct FinishPomodoroView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timerModel: TimerModel
    @State var isAnimating: Bool = false
    var room: Room
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("おつかれさまでした")
                .font(.system(.title, design: .monospaced))
                .fontWeight(.light)
                .foregroundColor(.white)
        }// VSTACK
        .onTapGesture {
            timerModel.isFinished = false
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)){
                isAnimating = true
            }
        }//: onAppear
        .onDisappear() {
            withAnimation(.easeOut(duration: 0.5)){
                isAnimating = true
            }
        }//: onAppear
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: room.gradientColors), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }//: BODY
}


// MARK: - PREVIEW
struct FinishPomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FinishPomodoroView(room: roomData[0]).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//            FinishPomorodoView(room: roomData[1]).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }.environmentObject(TimerModel())
        
    }
}
