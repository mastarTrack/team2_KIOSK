//
//  MenuOptionViewModel.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/8/26.
//

import Foundation

class MenuOptionViewModel {
    
    //MARK: - Enum
    enum MenuSectionType {
        case mainImage
        case iceHot
        case stepper
        case check
    }
    
    enum MinMax {
        case Min
        case Max
        case None
    }
    
    enum StepperAction {
        case Increase
        case Decrease
    }
    
    //MARK: - CLosures
    var shotCountChanged: ((Int, MinMax) -> Void)?

    //MARK: - Properties
    var activeSections: [MenuSectionType] = []
    
    var selectedSizeIndex: Int? = 0
    
    var cartManager = CartManager()

    var cartItem: CartItem
    
    //MARK: - Init
    init(cartManager: CartManager, menuItem: MenuItem) {
        self.cartManager = cartManager
        self.cartItem = CartItem(menu: menuItem, isIce: true, shotCount: 0, count: 1)
        checkedNewSection()
    }
}

//MARK: - METHOD: Update Date
extension MenuOptionViewModel {
    
    func updateSizeSelect(select: Int) {
        selectedSizeIndex = select
    }
    
    func updateMenuCount(action: StepperAction) {
        switch action {
        case .Increase:
            cartItem.count += 1
        case .Decrease:
            guard !(cartItem.count == 1) else { return }
            cartItem.count -= 1
        }
    }
    
    func updateIceHot(isIce: Bool) {
        cartItem.isIce = isIce
    }
    
    func updateShotCount(action: StepperAction) {
        let maxShotCount = cartItem.menu.options.extraShot?.max ?? 0
        let minShotCount = cartItem.menu.options.extraShot?.min ?? 0
        
        switch action {
        case .Increase:
            if cartItem.shotCount == maxShotCount {
                shotCountChanged?(cartItem.shotCount, .Max)
            } else if cartItem.shotCount + 1 == maxShotCount {
                cartItem.shotCount += 1
                shotCountChanged?(cartItem.shotCount, .Max)
            } else {
                cartItem.shotCount += 1
                shotCountChanged?(cartItem.shotCount, .None)
            }
        case .Decrease:
            if cartItem.shotCount == minShotCount {
                shotCountChanged?(cartItem.shotCount, .Min)
            } else if cartItem.shotCount - 1 == minShotCount {
                cartItem.shotCount -= 1
                shotCountChanged?(cartItem.shotCount, .Min)
            } else {
                cartItem.shotCount -= 1
                shotCountChanged?(cartItem.shotCount, .None)
            }
        }
    }
    
    func getShotCountState()-> MinMax {
        let shotCount = cartItem.shotCount
        let maxShotCount = cartItem.menu.options.extraShot?.max ?? 0
        let minShotCount = cartItem.menu.options.extraShot?.min ?? 0
        
        if shotCount == maxShotCount {
            return .Max
        } else if shotCount == minShotCount {
            return .Min
        } else {
            return .None
        }
    }
    
    func commitToCart() {
        cartManager.addItem(newItem: cartItem)
    }
}

//MARK: - METHOD: Set Section
extension MenuOptionViewModel {
    func checkedNewSection() {
        activeSections.append(.mainImage)
        if cartItem.menu.options.temperature?.count == 2 {
            activeSections.append(.iceHot)
        }
        if let extraShot = cartItem.menu.options.extraShot {
            if extraShot.max > 0 {
                activeSections.append(.stepper)
            }
        }
        if let size = cartItem.menu.options.size {
            if size.count > 0 {
                activeSections.append(.check)
                cartItem.option = ["SIZE":[:]]
                guard let size = cartItem.menu.options.size, size.count > 0 else { return }
                cartItem.option?["SIZE"] = [size.first ?? "" : 0]
            }
        }
    }
    
}

//MARK: - Sample Data
extension MenuOptionViewModel {
    func SetSampleData()-> CartItem {
        return CartItem(menu: MenuItem(
            id: "menu_001",
            categoryId: "coffee",
            name: "아메리카노",
            nameEn: "Americano",
            description: "에스프레소에 물을 더해 깔끔한 맛의 커피",
            price: 4500,
            imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20240610105645_1717984605982_8i5CoHU2NV.jpg",
            tags: ["BEST", "HOT", "ICE"],
            options: ItemOptions(
                temperature: ["HOT", "ICE"],
                size: ["TALL", "GRANDE", "VENTI"],
                extraShot: ExtraShot(
                    min: 0,
                    max: 3,
                    pricePerShot: 500
                ),
                iceLevel: ["LESS", "NORMAL", "MORE"]
            ),
            displayOrder: 1
        ),
                                isIce: true,
                                shotCount: 0,
                                count: 1
        )
    }
}
