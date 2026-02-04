//
//  CoffeeMenuDataService.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/4/26.
//

import Foundation

// coffeeMenu.json을 CoffeeMenuResponse로 바꾸는 역할 담당
class CoffeeMenuDataService {

    // 에러 처리
    enum DataError: Error {
        case fileNotFound // 파일이 없음
        case decodingError // JSON -> Swift 변환 실패
    }
    
    // 메뉴 데이터 로드 함수
    // 성공하면 CoffeeMenuResponse(전체 데이터), 실패하면 Error를 돌려줌
    func loadMenu(completion: @escaping (Result<CoffeeMenuResponse, Error>) -> Void) {
            
        // (1번 안전장치) coffeeMenu.json 파일이 있는지 확인
        guard let path = Bundle.main.path(forResource: "coffeeMenu", ofType: "json") else {
            print("🚨 파일을 찾을 수 없음")
            completion(.failure(DataError.fileNotFound))
            return
        }
            
        do {
            // (2번 안전장치) 파일 읽고 JSON 파싱
            let data = try Data(contentsOf: URL(fileURLWithPath: path)) // 파일 내용을 메모리로 읽어옴
            let decoder = JSONDecoder()
            let menuResponse = try decoder.decode(CoffeeMenuResponse.self, from: data) // JSON을 Swift 구조체로 해독
            completion(.success(menuResponse)) // 성공
                
        } catch {
            // 실패 시 에러 내용 출력 (디버깅용)
            print("🚨 JSON 파싱 에러 : \(error)")
            completion(.failure(DataError.decodingError))
        }
    }
}

/*
 구현부
 
 // 버튼을 누르거나 화면이 켜질 때 호출
 coffeeMenuDataService.loadMenu { result in
     switch result {
     case .success(let menuData):
         print("성공")
         print("브랜드명: \(menuData.brand.name)")
         print("메뉴 개수: \(menuData.items.count)")
         // 여기서 화면 업데이트 (예: self.items = menuData.items)
         
     case .failure(let error):
         print("실패: \(error)")
     }
 }
 
*/
