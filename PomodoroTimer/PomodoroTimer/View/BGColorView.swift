//
//  BGColorView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/30.
//

import SwiftUI

struct BGColorView: View {
    // MARK: - PROPERTIES
    var room: Room
    
    // MARK: - BODY
    var body: some View {
        VStack {
            
        }
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: room.gradientColors), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        
    }
}

// MARK: - PREVIEW
struct BGColorView_Previews: PreviewProvider {
    static var previews: some View {
        BGColorView(room: roomData[0])
    }
}
