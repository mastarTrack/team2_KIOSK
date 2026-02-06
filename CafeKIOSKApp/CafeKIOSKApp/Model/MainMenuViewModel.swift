//
//  MainMenuViewModel.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/6/26.
//
import UIKit

class MainMenuViewModel {
    let dataManager = CoffeeMenuDataService()
    var categories = [Category]() // 메뉴섹션
    
    var itemsByCategoryId = [String: [MenuItem]]() // 내꺼 내부 구성용
    var menuItems = [MenuItem]() // 상세화면 전달용
    var numOfPages =  [String: Int]() // 페이지컨트롤 구성용
    var selectedCategory = "season"
    
    var CategoryChanged: ((Category) -> Void)? // 밖에서 이걸로 카테고리 바뀐거 전달??
    
    var MenuSelected: ((MenuItem) -> Void)? // 선택된 해당 음료 전달
    
    var GridCellItems: (([String: [MenuItem]]) -> Void)? // 그리드 셀 정보...????
    
    var oneTimeUpdate: (() -> Void)?  // 메뉴 맨 처음에 그리는거??????????
    
    var update: (() -> Void)? // 이건 갱신용
    
    // 뷰에 뭘 줘야할까.. 일단 메뉴섹션어레이, 콜렉트뷰 셀 만들 어레이,, 이걸 어캐줌?? 클로저로??? 그럼 뷰컨에서 다 받아가???????
    
    func loadMenu() {
        dataManager.loadMenu { result in
            switch result {
            case .success(let menuData):
                self.categories = menuData.categories
                self.menuItems = menuData.items
                self.itemsByCategoryId = Dictionary(grouping: menuData.items) { $0.categoryId }
                
                self.oneTimeUpdate?()

            case .failure(let error):
                print("에러발생: \(error)")
            }
        }
    }
    
    
    func selecteCategory() {
        // 카테고리 선택되면 할 로직????
    }
    
    func selecteItem() {
        // 아이템 선택되면 할 로직??????
    }
}
