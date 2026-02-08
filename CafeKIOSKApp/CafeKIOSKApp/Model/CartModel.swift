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
    var option: [String:[String:Int]]? // [옵션명:[선택옵션명:가격]]
    
    func getTotalPrice() -> Int {
        var price = menu.price
        
        // 샷 가격 추가
        price += shotCount * (menu.options.extraShot?.pricePerShot ?? 0)
        
        // 옵션 가격 추가
        if let option {
            for (_, optionValues) in option {
                      for (_, optionPrice) in optionValues {
                          price += optionPrice
                      }
                  }
        }
        return price
    }
    
    static func SetSampleData()-> CartItem {
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
                                count: 0
        )
    }
}

// 2. 물건들이 담길 장바구니 그 자체 (아이템 추가, 가격 계산, 비우기 기능)
class CartManager {
    
    // 빈 장바구니 배열
    var items: [CartItem] = []
    
    var sum: ((Int)->Void)?
    
    var cartCount: ((Int)->Void)?
    
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

extension CartManager {
    func makeMockCartItems() -> [CartItem] {
        return [
            // 시즌 음료
            CartItem(
                menu: MenuItem(
                    id: "S01",
                    categoryId: "season",
                    name: "말차젤라또 퐁당 딸기프라페",
                    nameEn: "Matcha Gelato Strawberry Frappe",
                    description: "말차 젤라또와 딸기 밀크 쉐이크가 어우러진 프라페",
                    price: 4900,
                    imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20251226201136_1766747496618_B9SxVDjAvl.png",
                    tags: ["NEW", "RECOMMEND", "SEASON"],
                    options: ItemOptions(
                        temperature: ["ICE"],
                        size: ["REGULAR"],
                        extraShot: ExtraShot(min: 0, max: 0, pricePerShot: nil),
                        iceLevel: nil
                    ),
                    displayOrder: 1
                ),
                isIce: true,
                shotCount: 0,
                count: 1
            ),

            // 커피
            CartItem(
                menu: MenuItem(
                    id: "M101",
                    categoryId: "coffee",
                    name: "아메리카노",
                    nameEn: "Americano",
                    description: "진한 에스프레소에 물을 더한 기본 커피",
                    price: 2000,
                    imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20240610105645_1717984605982_8i5CoHU2NV.jpg",
                    tags: ["OFFICIAL_IMAGE"],
                    options: ItemOptions(
                        temperature: ["HOT", "ICE"],
                        size: ["REGULAR"],
                        extraShot: ExtraShot(min: 0, max: 3, pricePerShot: 500),
                        iceLevel: nil
                    ),
                    displayOrder: 101
                ),
                isIce: false,
                shotCount: 2,
                count: 2
            ),

            // 아이스 커피
            CartItem(
                menu: MenuItem(
                    id: "M102",
                    categoryId: "coffee",
                    name: "아이스 아메리카노",
                    nameEn: "Iced Americano",
                    description: "깔끔한 아메리카노를 시원하게",
                    price: 2000,
                    imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20240610133007_1717993807130_nwB5CATOJJ.jpg",
                    tags: ["OFFICIAL_IMAGE"],
                    options: ItemOptions(
                        temperature: ["ICE"],
                        size: ["REGULAR"],
                        extraShot: ExtraShot(min: 0, max: 3, pricePerShot: 500),
                        iceLevel: nil
                    ),
                    displayOrder: 102
                ),
                isIce: true,
                shotCount: 1,
                count: 1
            ),

            // 라떼
            CartItem(
                menu: MenuItem(
                    id: "M115",
                    categoryId: "coffee",
                    name: "바닐라라떼",
                    nameEn: "Vanilla Latte",
                    description: "부드러운 우유와 바닐라 향이 어우러진 라떼",
                    price: 3800,
                    imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20240610104603_1717983963750_lApih2z1h0.jpg",
                    tags: ["OFFICIAL_IMAGE"],
                    options: ItemOptions(
                        temperature: ["HOT", "ICE"],
                        size: ["REGULAR"],
                        extraShot: ExtraShot(min: 0, max: 3, pricePerShot: 500),
                        iceLevel: nil
                    ),
                    displayOrder: 115
                ),
                isIce: true,
                shotCount: 0,
                count: 3
            ),

            // 푸드
            CartItem(
                menu: MenuItem(
                    id: "F01",
                    categoryId: "food",
                    name: "딸기 크림치즈 쫀득빵",
                    nameEn: "Strawberry Cream Cheese Chewy Bread",
                    description: "딸기 콤포트와 크림치즈가 가득한 쫀득빵",
                    price: 3300,
                    imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20251226202655_1766748415087_NsW1Ifwl8a.png",
                    tags: ["NEW", "SEASON"],
                    options: ItemOptions(
                        temperature: [],
                        size: [],
                        extraShot: nil,
                        iceLevel: nil
                    ),
                    displayOrder: 101
                ),
                isIce: false,
                shotCount: 0,
                count: 2
            )
        ]
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
