//
//  CoffeeModels.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/3/26.
//

import Foundation


// MARK: -- CoffeModel 데이터

// 최상위 모델
struct CoffeeMenuResponse: Decodable {
    let brand: Brand
    let categories: [Category]
    let recommendedIds: [String]
    let items: [MenuItem]
}

// brand
struct Brand: Decodable {
    let name: String
    let note: String
  }

// category
struct Category: Decodable {
    let id: String
    let name: String
    let description: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        let rawName = try container.decode(String.self, forKey: .name)
        name = rawName.replacingOccurrences(of: "_", with: "/")
    }
}

// menuItem
struct MenuItem: Decodable {
    let id: String
    let categoryId: String
    let name: String
    let nameEn: String
    let description: String
    let price: Int
    let imageUrl: String
    let tags: [String]
    let options: ItemOptions
    let displayOrder: Int
}

// itemOptions
struct ItemOptions: Decodable {
    let temperature: [String]?
    let size: [String]?
    
    let extraShot: ExtraShot? // 없는 메뉴도 존재
    let iceLevel: [String]? // 없는 메뉴도 존재
}

// extraShot
struct ExtraShot: Decodable {
    let min: Int
    let max: Int
    let pricePerShot: Int? // 없는 메뉴도 존재
}
