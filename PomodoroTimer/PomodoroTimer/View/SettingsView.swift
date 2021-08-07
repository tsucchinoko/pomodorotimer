//
//  SettingsView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/30.
//

import SwiftUI

struct SettingsView: View {
    
    //モーダルシートを利用するためのプロパティ
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var timerModel: TimerModel
    
    var body: some View {
        //Form内から別のFormやListに遷移可能
        NavigationView {
            //リスト表示のコンポーネントはFormかList（設定はForm、　TODOはListが多い）
            Form {
                Section(header: Text("BGM:").font(.system(.body, design: .monospaced))) {
                    Toggle(isOn: $timerModel.isBGMOn) {
                        Text("BGM Sound").font(.system(.body, design: .monospaced))
                    }
                    Toggle(isOn: $timerModel.isRestBGMOn) {
                        Text("REST BGM Sound").font(.system(.body, design: .monospaced))
                    }
                    Toggle(isOn: $timerModel.isVibrationOn) {
                        Text("Vibration").font(.system(.body, design: .monospaced))
                    }
                    
//                    //サウンド選択画面へ画面遷移 TODO
//                    NavigationLink(destination: SoundListView()) {
//                        HStack {
//                            Text("Sound Selection")
//                            Spacer()
//                            Text("\(timerModel.soundName)")
//                        }
//                    }//: NAV LINK
                }
                
                Section(header: Text("保存:").font(.system(.body, design: .monospaced))) {
                    Button(action: {
                        //タップしたらモーダルを閉じる
                        print("tapped 保存ボタン")
                        timerModel.hideSettingsView()
                    }) {
                        HStack {
                            Spacer()
                            Text("Done!")
                                .font(.system(.body, design: .monospaced))
                            Image(systemName: "checkmark.circle")
                            Spacer()
                        }
                        
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
