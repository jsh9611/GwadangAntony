//
//  OnboardingUserInfoView.swift
//  GwadangAntony
//
//  Created by SeongHoon Jang on 2022/06/05.
//

import SwiftUI

struct UserInfoView: View {
    @AppStorage(StorageKeys.nickName.rawValue) private var nickName: String = UserDefaults.standard.string(forKey: "nickName") ?? ""    // 닉네임
    @AppStorage(StorageKeys.gender.rawValue) var gender: Int = UserDefaults.standard.integer(forKey: "gender") // 유저의 성별(남:0, 여:1)
    @AppStorage(StorageKeys.age.rawValue) var age: Int =  UserDefaults.standard.integer(forKey: "age") // 유저의 만나이
    @AppStorage(StorageKeys.sugar.rawValue) var sugar : Double = UserDefaults.standard.double(forKey: "sugar")  // 유저의 설탕값
    
    @State private var birthDate : Date = Calendar.current.date(byAdding: DateComponents(year: -1), to: Date()) ?? Date()   // 유저 생일 정보
    
    @Binding var isFirstLaunching: Bool
    
    let genderType = ["남성","여성"]    // 성별 테이블
    
    var body: some View {
        NavigationView {
            VStack{
                
                Form{
                    // 닉네임 입력
                    Section(header: Text("닉네임"), content: {
                        TextField("닉네임을 입력하세요.", text: $nickName).keyboardType(.default)
                    })
                    // 생일 선택 피커
                    Section(header: Text("생일")){
                        // 1. DatePicker(달력)를 사용한 생일 선택 방법
                        DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                            Text("날짜를 선택하세요")
                        }
                        
//                        // 2. 피커 + 1900~2021년의 리스트로 생일 선택 방법
//                        Picker("출생년도",selection: $age){
//                            // 1900부터 2021까지 Text를 만듭니다.
//                            ForEach(1900 ..< 2022 ){
//                                Text("\(String($0))년생")
//                            }
//                        }
                        
                    }
            
                    // 성별 선택 피커
                    Section(header: Text("성별")){
                        // 남성, 여성 버튼을 피커로 구현
                        Picker("성별",selection: $gender){
                            ForEach( 0  ..< genderType.count, id: \.self){
                                Text("\(self.genderType[$0])")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                    }

                    NavigationLink(destination: UserSugarView(isFirstLaunching: $isFirstLaunching)) { Text("다음으로") }
                    .buttonStyle(PlainButtonStyle())
                    
                    // 1살 미만인 경우 "다음으로" 버튼을 비활성화 한다.
                    .disabled(computeAge(from: birthDate, to: Date()) < 0.9)
                }
            }
        }
        // 달력의 값이 변경될 때 마다 설탕 값 새롭게 갱신
        .onChange(of: $birthDate.wrappedValue) { newValue in
            sugar = sugarGram()
        }
        // 성별의 값이 변경될 때 마다 설탕 값 새롭게 갱신
        .onChange(of: $gender.wrappedValue) { newValue in
            sugar = sugarGram()
        }
    }
    
    // 생일과 현재시간을 비교해 만나이를 구하는 함수
    func computeAge(from fromDate: Date, to toDate: Date) -> Float  {
        // timeIntervalSince: fromDate로 부터 toDate의 시간차이를 초(sec)로 반환한다.
        let birthdaySec = toDate.timeIntervalSince(fromDate)

        age = Int((birthdaySec / 31536000))
        
        // 만나이 계산: (현재 날짜 - 생일 날짜) 를 초로 변환한 것을 (초 * 분 * 시간 * 일)로 나누어준다.
        // 60초 * 60분 * 24시간 * 365일 = 31536000초
        print("너 나이는 만으로 \(Float(birthdaySec / 31536000))살")
        return Float((birthdaySec / 31536000))
    }
    
    // 나이와 성별에 따른 kcal를 통해 권장 섭취 당을 구하는 함수
    func sugarGram() -> Double {
        var kcal : Double = 0
        
        if gender == 0 {    // 남자인 경우
            switch age {
            case 1...2:     // 1~2 세
                kcal = 900
            case 3...5:
                kcal = 1400
            case 6...8:
                kcal = 1700
            case 9...11:
                kcal = 2000
            case 12...14:
                kcal = 2500
            case 15...18:
                kcal = 2700
            case 19...29:
                kcal = 2600
            case 30...49:
                kcal = 2500
            case 50...64:
                kcal = 2200
            case 65...74:
                kcal = 2000
            case 75... :
                kcal = 1900
            default:
                kcal = 0
            }
        } else if gender == 1 { // 여자인 경우
            switch age {
            case 1...2:
                kcal = 900
            case 3...5:
                kcal = 1400
            case 6...8:
                kcal = 1500
            case 9...11:
                kcal = 1800
            case 12...14:
                kcal = 2000
            case 15...18:
                kcal = 2000
            case 19...29:
                kcal = 2000
            case 30...49:
                kcal = 1900
            case 50...64:
                kcal = 1700
            case 65...74:
                kcal = 1600
            case 75... :
                 kcal = 1500
            default:
                kcal = 0
            }
        }
        // 하루 필요 추정량(kcal)의 10%에 대한 당(g)을 계산
        return kcal / 40
    }
    
}

//struct OnboardingUserInfo_View_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingUserInfo_View()
//    }
//}
