//
//  TimeView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/27.
//

import SwiftUI

struct TimeView: View {
    
    @EnvironmentObject var timerModel: TimerModel
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        //時間表示
            Text(self.timerModel.displayTimer())
                .font(.system(size: self.screenWidth * 0.18, weight: .thin, design: .monospaced))
                .foregroundColor(.white)
                .lineLimit(1)
                .padding()
    }
}

struct TimeView_Previews: PreviewProvider {
    static var previews: some View {
        TimeView()
            .environmentObject(TimerModel())
            .colorScheme(.dark)
            .previewLayout(.sizeThatFits)
            
    }
}

