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
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    
    var body: some View {
        //Form内から別のFormやListに遷移可能
        NavigationView {
            //リスト表示のコンポーネントはFormかList（設定はForm、　TODOはListが多い）
            Form {
                Section(header: Text("オーディオ設定").font(.system(.body, design: .monospaced))) {
                    Toggle(isOn: $timerModel.isBGMOn) {
                        Text("音を鳴らす").font(.system(.body, design: .monospaced))
                    }
                    Toggle(isOn: $timerModel.isVibrationOn) {
                        Text("バイブさせる").font(.system(.body, design: .monospaced))
                    }
                    
//                    //サウンド選択画面へ画面遷移 TODO
//                    NavigationLink(destination: SoundListView()) {
//                        HStack {
//                            Text("Sound Selection")
//                            Spacer()
//                            Text("\(timerModel.soundName)")
//                        }
//                    }//: NAV LINK
                }//: SECTION
                Section(header: Text("アプリ情報").font(.system(.body, design: .monospaced))) {
                    HStack {
                        Image("twitter")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Link("開発者(Twitter)", destination: URL(string: "https://twitter.com/tsuchiiinoko21")!)
                        Spacer()
                        Image(systemName: "arrow.up.forward.app.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    HStack {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Link("アプリの評価", destination: URL(string: "https://twitter.com/tsuchiiinoko21")!)
                        Spacer()
                        Image(systemName: "arrow.up.forward.app.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    HStack {
                        Image(systemName: "hammer.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Link("フィードバックを送信", destination: URL(string: "https://twitter.com/tsuchiiinoko21")!)
                        Spacer()
                        Image(systemName: "arrow.up.forward.app.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    HStack {
                        Text("バージョン:")
                        Spacer()
                        Text(version)
                    }
                }
                    Button(action: {
                        //タップしたらモーダルを閉じる
                        timerModel.hideSettingsView(isBGMOn: timerModel.isBGMOn, isVibrationOn: timerModel.isVibrationOn)
                    }) {
                        HStack {
                            Spacer()
                            Text("保存")
                                .font(.system(.body, design: .monospaced))
                            Image(systemName: "checkmark.circle")
                            Spacer()
                        }//: HSTACK
                        
                    }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(TimerModel())
    }
}
