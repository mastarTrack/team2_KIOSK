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

extension LabelConfiguration {
    static let headerTitle = LabelConfiguration(
        font: .preferredFont(forTextStyle: .largeTitle),
        color: .black,
        lines: 0
    )
}

