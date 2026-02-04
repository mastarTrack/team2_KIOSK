//
//  MainBottomView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/4/26.
//
import Foundation
import UIKit
import SnapKit

class MainBottomView: UIView {
    let shoppingCartButton = UIButton()
    let labelStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 10
        labelStackView.alignment = .leading
        labelStackView.distribution = .fill
        
        let priceNameLabel = UILabel(text: "총 금액", config: .mainPriceLabel)
        let priceLabel = UILabel()
    }
}
