//
//  SettingsButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/30.
//

import SwiftUI

struct SettingsButtonView: View {
    @EnvironmentObject var timerModel: TimerModel
    
    var body: some View {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .onTapGesture {
                    timerModel.showSettingsView()
                }
    }
}

//struct SettingsButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsButtonView()
//    }
//}
