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
    var selectedCategory = "season"
    var oneTimeUpdate: (() -> Void)?  // 메뉴 맨 처음에 그리는거??????????
        
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
}
