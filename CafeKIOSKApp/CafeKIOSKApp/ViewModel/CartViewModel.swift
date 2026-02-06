//
//  CartViewModel.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/6/26.
//

import Foundation

class CartViewModel{
    
    private var cartManager = CartManager()
    
    // View 갱신용 클로저
    var dataChanged: (() -> Void)?
    
    func fetchData() {
        let mockItems = cartManager.makeMockCartItems()
        
        cartManager.items = mockItems
        
        dataChanged?()
        }
    // 테이블뷰 행 개수
    var rowCount: Int {
        return cartManager.items.count
    }
    
//    func toggleSelectAll() {  
//        // 1. 모든 요소가 true인지 검사
//        let isAllSelected = cartManager.items.allSatisfy { $0.isSelected == true }
//        
//        // 2. 반대 상태로 설정하기
//    }
//    
    // 특정한 인덱스값의 items 반환하기
    func item(at index: Int) -> CartItem {
        return cartManager.items[index]
    }
    
    // 아이템 삭제하기
    func removeItem(at index: Int) {
        cartManager.items.remove(at: index)
        
        dataChanged?()
    }
    
    // 수량 증가 함수
    func increaseCount(at index: Int) {
        cartManager.items[index].count += 1
        dataChanged?()
    }
    
    func decreaseCount(at index: Int) {
        if cartManager.items[index].count > 1 {
            cartManager.items[index].count -= 1
            dataChanged?()
        }
    }

    func ToggleAllSelection() {
        let isAllSelected = cartManager.items.allSatisfy { $0.isSelected! }
        
        // 다 선택되어있으면 모두 해제하기, 그게 아니면 전부 선택시킴
        let newValue = !isAllSelected
        
        for i in 0..<cartManager.items.count {
            cartManager.items[i].isSelected = newValue
        }
        
        dataChanged?()
    }
    
    func toggleSelection(at index: Int) {
        cartManager.items[index].isSelected?.toggle()
        dataChanged?()
    }
        
    var selectedCount: Int {
        return cartManager.items.filter { $0.isSelected! }.count
        }
    
    var totalPrice: Int {
        let total = cartManager.calculateTotal()
        return total
    }
    
}

