//
//  ChangeUserSugar.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/05.
//

import SwiftUI

struct ChangeUserSugar: View {
    @AppStorage(StorageKeys.sugar.rawValue) private var sugar : Double = UserDefaults.standard.double(forKey: "sugar")
    
    var body: some View {
        VStack {
            Section(header: Text("설탕을 세팅해주세요"), content: {
                Slider(value: $sugar, in: 0...100, step: 5.0)
                    .padding()
            })
            Text("세팅한 설탕은 \(Int(sugar))g 입니다.")
        }
        
    }
}

struct ChangeUserSugar_Previews: PreviewProvider {
    static var previews: some View {
        ChangeUserSugar()
    }
}
