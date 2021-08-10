//
//  BackButtonView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/30.
//

import SwiftUI

struct BackButtonView: View {
    @EnvironmentObject var timerModel: TimerModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack {
            Image(systemName: "chevron.backward")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
            Text("戻る")
                .font(.system(.title3, design: .monospaced))
        }//: HStack
        .onTapGesture {
            self.timerModel.isSetting = false
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
