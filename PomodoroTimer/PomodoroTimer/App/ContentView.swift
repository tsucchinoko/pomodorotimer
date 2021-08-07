//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var timerModel: TimerModel
    @Environment(\.presentationMode) var presentationMode

    var rooms: [Room] = roomData
    
    
    // MARK: - BODY
    var body: some View {
            NavigationView {
                
                TabView {
                    ForEach(0..<rooms.count) { item in
                            RoomCardView(room: rooms[item])
                                .navigationBarHidden(true)
                    }//: LOOP
                } //: TabView
                .tabViewStyle(PageTabViewStyle())
            }//: NAV
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(timerModel)
    }//: BODY
}


// MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(rooms: roomData).previewDevice(PreviewDevice(rawValue: "iPhone 12"))
//            ContentView(rooms: roomData).previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        }.environmentObject(TimerModel())
    }
}
