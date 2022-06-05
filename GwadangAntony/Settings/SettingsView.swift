//
//  SettingsView.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/05.
//

import SwiftUI

struct SettingsView: View {
    @State private var pushAlert = true
    
    @Binding var isFirstLaunching : Bool
    
    var body: some View {
        List {
            NavigationLink(destination: ChangUserInfo()) {
                Text("개인정보 변경")
            }
            NavigationLink(destination: ChangeUserSugar()) {
                Text("목표 섭취량 변경")
            }
            Toggle("Push 알림 설정", isOn: $pushAlert)
            Toggle("온보딩 OnOff 테스트용입니다", isOn: $isFirstLaunching)
        }
        .navigationBarTitle("Settings")
    }
}
