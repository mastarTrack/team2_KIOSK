//
//  CartViewModel.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/6/26.
//

import Foundation

class CartViewModel{
    var items: [CartItem] = []
    
    // View 갱신용 클로저
    var dataChanged: (() -> Void)?
    
    // 외부에서 받아올 변수로 변경
    let cartManager: CartManager
    
    // 생성자 추가: 밖에서 던져주는 cartManager를 받음
    init(cartManager: CartManager) {
        self.cartManager = cartManager
    }
    
    func fetchData() {
        self.items = cartManager.items
        dataChanged?()
    }
    
    // 테이블뷰 행 개수
    var rowCount: Int {
        return cartManager.items.count
    }
    
    // 선택된 아이템의 개수
    var selectedCount: Int {
        return cartManager.items.filter { $0.isSelected! }.count
    }
    
    var totalPrice: Int {
        let total = cartManager.calculateTotal()
        return total
    }
    
    
    // 특정한 인덱스값의 items 반환하기
    func item(at index: Int) -> CartItem {
        return cartManager.items[index]
    }
    
    // 아이템 삭제하기
    func removeItem(at index: Int) {
        cartManager.items.remove(at: index)
        dataChanged?()
    }
    
    // 아이템 전체 삭제하기
    func removeItemAll() {
        cartManager.items.removeAll()
        dataChanged?()
    }
    
    // 수량 증가 함수
    func increaseCount(at index: Int) {
        cartManager.items[index].count += 1
        dataChanged?()
    }
    
    // 수량 감소 함수
    func decreaseCount(at index: Int) {
        if cartManager.items[index].count > 1 {
            cartManager.items[index].count -= 1
            dataChanged?()
        }
    }
    
    // 전체 선택 함수
    func ToggleAllSelection() {
        let isAllSelected = cartManager.items.allSatisfy { $0.isSelected! }
        
        // 다 선택되어있으면 모두 해제하기, 그게 아니면 전부 선택시킴
        let newValue = !isAllSelected
        
        for i in 0..<cartManager.items.count {
            cartManager.items[i].isSelected = newValue
        }
        dataChanged?()
    }
    
    // 선택버튼 함수
    func toggleSelection(at index: Int) {
        cartManager.items[index].isSelected?.toggle()
        dataChanged?()
    }
}
