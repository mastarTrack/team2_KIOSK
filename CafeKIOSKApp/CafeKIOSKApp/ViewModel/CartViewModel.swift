//
//  CartViewModel.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/6/26.
//

import Foundation

class CartViewModel{
    
    
//    // 4. 실제 데이터를 가져와서 장바구니에 넣는 함수
//    func fetchData() {
//        dataService.loadMenu { [weak self] result in
//            guard let self = self else { return }
//            
//            switch result {
//            case .success(let response):
//                // 전체 메뉴 리스트 가져옴
//                let menuItems = response.items
//                
//                // 1) 아메리카노 찾아서 담기 (1잔, 핫, 1샷)
//                if let americano = menuItems.first(where: { $0.name == "아메리카노" }) {
//                    let item = CartItem(menu: americano, isIce: false, shotCount: 1, count: 1)
//                    self.cartList.append(item)
//                }
//                
//                // 2) 딸기 스무디(S03) 찾아서 담기 (1잔, 샷추가 2번)
//                if let smoothie = menuItems.first(where: { $0.id == "S03" }) {
//                    let item = CartItem(menu: smoothie, isIce: true, shotCount: 2, count: 1)
//                    self.cartList.append(item)
//                }
//                
//                // 3) 로꾸거 찾아서 담기 (1잔)
//                if let americano = menuItems.first(where: { $0.name == "로꾸거 딸기젤라또 콘케이크" }) {
//                    let item = CartItem(menu: americano, isIce: false, shotCount: 2, count: 1)
//                    self.cartList.append(item)
//                }
//                
//                // 4) 데이터가 준비되었으니 화면을 갱신하라고 알림 (메인 스레드에서)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                
//            case .failure(let error):
//                print("데이터 가져오기 실패: \(error)")
//            }
//        }
//    }
    
}
