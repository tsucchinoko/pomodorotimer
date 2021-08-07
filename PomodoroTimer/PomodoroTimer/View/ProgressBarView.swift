//
//  ProgressBarView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/27.
//


import SwiftUI

struct ProgressBarView: View {
    @EnvironmentObject var timerModel: TimerModel
    
    @State var costomHueA: Double = 1.0
    @State var customHueB: Double = 0.5
    
    var body: some View {
        
        ZStack {
        //背景用の円
        Circle()
            .stroke(Color(.darkGray), style: StrokeStyle(lineWidth: 20))
            .scaledToFit()
            .padding(30)
        
        //プログレスバー用の円
        Circle()
            //残り時間によってバーの長さ変化
            .trim(from: 0, to: CGFloat(self.timerModel.duration / self.timerModel.maxValue))
            .stroke(self.makeGradientColor(hueA: costomHueA, hueB: customHueB), style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
            .scaledToFit()
            .padding(30)
            //輪郭の表示位置を12時の方向にする
            .rotationEffect(Angle(degrees: -90))
        }
        .onReceive(timerModel.timer) { _ in
                    self.costomHueA += 0.005
                    if self.costomHueA >= 1.0 {
                        self.costomHueA = 0.0
                    }
                    self.customHueB += 0.005
                    if self.customHueB >= 1.0 {
                        self.customHueB = 0.0
                    }
                }
    }
    
    
    
    func makeGradientColor (hueA: Double, hueB: Double)-> AngularGradient {
        let colorA = Color(hue: hueA, saturation: 0.75, brightness: 0.9)
        let colorB = Color(hue: hueB, saturation: 0.75, brightness: 0.9)
        let gradient = AngularGradient(gradient: .init(colors: [colorA, colorB, colorA]), center: .center, startAngle: .zero, endAngle: .init(degrees: 360))
        
        return gradient
        
    }
}

