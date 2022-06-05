//
//  MainPageView.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/05.
//

import SwiftUI

struct MainPageView: View {
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    @AppStorage(StorageKeys.todaySugar.rawValue) private var todaySugar : Double = UserDefaults.standard.double(forKey: "todaySugar")
    
    @Binding var isFirstLaunching: Bool
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    NavigationLink(destination: SettingsView(isFirstLaunching: $isFirstLaunching)) { Text("세팅으로") }
                        .padding()
                }
                Spacer()
                Text("오늘 먹은 설탕은 \(todaySugar)입니다.")
                Text("세팅힌 설탕 값은 \(sugar)입니다.")
                Text("엄마 보고 싶다😭😭")
                Spacer()
            }
        }
        
    }
}
