//
//  LabelConfiguration.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/3/26.
//
import UIKit

struct LabelConfiguration {
    let font: UIFont
    let color: UIColor
    let lines: Int
}
// MARK: - 메인 화면 라벨 규격
extension LabelConfiguration {
    static let priceNameLabel = LabelConfiguration(
        font: .preferredFont(forTextStyle: .body),
        color: .black,
        lines: 0
    )
    
    static let priceLabel = LabelConfiguration(
        font: .preferredFont(forTextStyle: .title2),
        color: .black,
        lines: 0
    )
    
    static let drinkLabel = LabelConfiguration(
        font: .preferredFont(forTextStyle: .callout),
        color: .black,
        lines: 0
    )
}


// MARK: - 메뉴 상세 화면 라벨 규격
extension LabelConfiguration {
    static let descriptionTitle = LabelConfiguration(
        font: .boldSystemFont(ofSize: 20),
        color: .black,
        lines: 0
    )
    
    static let descriptionText = LabelConfiguration(
        font: .systemFont(ofSize: 15),
        color: .systemGray,
        lines: 0
    )
}
