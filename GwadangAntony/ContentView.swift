//
//  ContentView.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/05.
//

import SwiftUI

struct ContentView: View {
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수.
    // @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    // https://velog.io/@seodam_hst/SwiftUI-%EC%98%A8%EB%B3%B4%EB%94%A9Onboarding-%ED%99%94%EB%A9%B4-%EB%A7%8C%EB%93%A4%EA%B8%B0
    @AppStorage(StorageKeys.isFirstLaunching.rawValue) private var isFirstLaunching: Bool = true
    
    var body: some View {
        // 맨 처음 실행한 경우 온보딩 페이지로 이동.
        if isFirstLaunching {
            UserInfoView(isFirstLaunching: $isFirstLaunching)
        } else {
        // 실행한 적이 있었다면 메인 페이지로 이동.
            MainPageView(isFirstLaunching: $isFirstLaunching)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
