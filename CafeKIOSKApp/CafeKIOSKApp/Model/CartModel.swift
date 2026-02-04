//
//  CartModel.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/3/26.
//
import Foundation


// 1. 장바구니에 담긴 물건 하나의 정보
struct CartItem {
    var menu: MenuItem      // 메뉴 정보 (이름, 가격 등)
    var isIce: Bool         // 아이스 여부 (true면 아이스)
    var shotCount: Int      // 샷 추가 횟수 (안했으면 0)
    var count: Int          // 주문 수량 (몇 잔)
}

// 2. 물건들이 담길 장바구니 그 자체 (아이템 추가, 가격 계산, 비우기 기능)
class CartManager {
    
    // 빈 장바구니 배열
    var items: [CartItem] = []
    
    // 장바구니에 아이템을 추가하는 함수
    func addItem(menu: MenuItem, isIce: Bool, shotCount: Int, count: Int) {
        
        // 새로운 아이템 만들기
        let newItem = CartItem(
            menu: menu,
            isIce: isIce,
            shotCount: shotCount,
            count: count
        )
        
        // 빈 장바구니 배열에 집어넣기
        items.append(newItem)
        print("\(newItem.menu.name)가 \(newItem.count)개가 장바구니에 추가되었습니다!")
    }
    
    // 총 가격 계산하는 함수
    func calculateTotal() -> Int {
        var total = 0
        
        // 배열에 있는 걸 하나씩 꺼내서 계산하기
        for item in items {
            // 1.메뉴 기본 가격
            var price = item.menu.price
            
            // 2.샷 추가 가격 계산 (샷이 없는 메뉴도 존재함)
            if let shotPrice = item.menu.options.extraShot?.pricePerShot {
                price = price + (shotPrice * item.shotCount)
            }
            
            // 3.해당 항목의 수량만큼 곱하기
            price = price * item.count
            
            // 4.전체 합계에 더하기
            total = total + price
        }
        
        return total
    }
    
    // 장바구니 비우기
    func clear() {
        items.removeAll() // 배열 전체 지우기
    }
}

/* 장바구니에 물건 넣기 구현 예시
 
 // 1. 인스턴스 생성하기
 let coffeeMenudataService = CoffeeMenuDataService()   // 데이터 담당
 let cartManager = CartManager()                       // 장바구니 담당
 // 2. 데이터 불러오기
 coffeeMenudataService.loadMenu { result in
     switch result {
     case .success(let menuData):
         let menuList = menuData.items
 
         // 🛒🚶🏼‍♀️ 3. 아아와 라떼를 찾아서 장바구니에 넣기 👇👇👇👇👇👇👇👇
         // 이름으로 아메리카노 찾기
         if let americano = menuList.first(where: { $0.name == "아메리카노" }) {
             self.cartManager.addItem(menu: americano, isIce: false, shotCount: 1, count: 1)
         }
         // id로 그린키위 콕콕 딸기스무디 찾기
         if let menu2 = menuList.first(where: { $0.id == "S03"}) {
            self.cartManager.addItem(menu: menu2, isIce: true, shotCount: 2, count: 1)
         }
         // 아메리카노,1샷 + 그린키위 콕콕 딸기스무디 = 2500+4800 = 7300원 출력
         print("현재 금액: \(self.cartManager.calculateTotal())원")
         
     case .failure(let error):
         print("에러발생: \(error)")
     }
 }
 */
