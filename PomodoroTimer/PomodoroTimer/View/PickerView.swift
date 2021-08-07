//
//  PickerView.swift
//  PomodoroTimer
//
//  Created by Daichi Tsuchiya on 2021/07/26.
//

import SwiftUI

struct PickerView: View {
    //TimeModelのインスタンスを作成
    @EnvironmentObject var timerModel: TimerModel
    //デバイスのスクリーンの幅
    let screenWidth = UIScreen.main.bounds.width
    //デバイスのスクリーンの高さ
    let screenHeight = UIScreen.main.bounds.height

    //設定可能な分単位の数値
    var minutes = [Int](1...60)
    
    //設定可能な秒単位の数値
    var seconds = [Int](0..<60)
    
    //設定可能な休憩時間の数値
    var rests = [Int](1...60)
    
    //設定可能なセット回数の数値
    var sets = [Int](1...10)
    
    var body: some View {
        //ZStackでPickerとレイヤーで重なるようにボタンを配置
        ZStack{
            VStack {
                HStack {
                    //分単位を表すテキスト
                    Text("活動時間")
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.white)
                    Spacer()
                    //分単位のPicker
                    Picker(selection: self.$timerModel.minSelection, label: Text("minute")) {
                        ForEach(0 ..< self.minutes.count) { index in
                            Text("\(self.minutes[index])")
                                .foregroundColor(.white)
                        }
                    }//: Picker
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: self.screenWidth * 0.1, height: self.screenWidth * 0.2)
                    .clipped()
                    
                    //分単位を表すテキスト
                    Text("分")
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.white)
                }//: HSTACK
                Spacer()
                
                HStack {
                    //休憩時間を表すテキスト
                    Text("休憩時間")
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.white)
                    
                    Spacer()
                    //秒単位のPicker
                    Picker(selection: self.$timerModel.restMinSelection, label: Text("rest")) {
                        ForEach(0 ..< self.rests.count) { index in
                            Text("\(self.rests[index])")
                                .tag(index)
                                .foregroundColor(.white)
                        }
                    }//: Picker
                    .pickerStyle(WheelPickerStyle())
                    .frame(width:self.screenWidth * 0.1, height: self.screenWidth * 0.2)
                    .clipped()
                    
                    Text("分")
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.white)
                }//: HSTACK
                
                Spacer()
                
                HStack {
                    //セット回数を表すテキスト
                    Text("回数")
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.white)
                    
                    Spacer()
                    //セット回数のPicker
                    Picker(selection: self.$timerModel.countSelection, label: Text("set")) {
                        ForEach(0 ..< self.sets.count) { index in
                            Text("\(self.sets[index])")
                                .tag(index)
                                .foregroundColor(.white)
                        }
                    }//: Picker
                    .pickerStyle(WheelPickerStyle())
                    .frame(width:self.screenWidth * 0.1, height: self.screenWidth * 0.2)
                    .clipped()
                    
                    Text("セット")
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.white)
                }//: HSTACK
            }//: VSTACK
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        }//: ZSTACK
        .fixedSize()
        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity)

    }
}

//struct PickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        PickerView()
//            .environmentObject(TimerModel())
//            .previewLayout(.sizeThatFits)
//            .preferredColorScheme(.dark)
//    }
//}
