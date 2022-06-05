//
//  UserSugarView.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/05.
//

import SwiftUI

struct UserSugarView: View {
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    
    @Binding var isFirstLaunching: Bool
    
    let genderType = ["남성","여성"]
    
    var body: some View {
        Form {
            VStack {
                Section(header: Text("설탕을 세팅해주세요"), content: {
                    Slider(value: $sugar, in: 0...100, step: 5.0)
                        .padding()
                })
                
                Text("세팅한 설탕은 \(Int(sugar))g 입니다.")
                Spacer()
                Button {
                    isFirstLaunching.toggle()
                } label: {
                    Text("시작하기")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(6)
                }
                .padding()
            }
        }
    }
    
}

