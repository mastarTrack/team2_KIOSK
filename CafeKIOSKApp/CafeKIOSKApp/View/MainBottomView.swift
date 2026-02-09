//
//  MainBottomView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/4/26.
//
import Foundation
import UIKit
import SnapKit
import Then

class MainBottomView: UIView {
    let shoppingCartButton = UIButton()
    let priceLabel = UILabel()
    var cartCount = 0
    var priceCount = "0"
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    var onTapCartButton: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        backgroundColor = .white
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(cartCount: Int, price: Int) {
        priceLabel.text = formatAsCurrency(intMoney: price)
        
        shoppingCartButton.configuration?.subtitle =
        "총 수량: \(cartCount)개"
    }
    
    func configure() {
        shoppingCartButton.applyBig()
        shoppingCartButton.configuration?.title = "장바구니 가기"
        shoppingCartButton.configuration?.subtitle = "총 수량: \(cartCount)개"
        shoppingCartButton.configuration?.image = UIImage(systemName: "cart")
        shoppingCartButton.configuration?.baseBackgroundColor = .brown
        
        shoppingCartButton.addTarget(
            self,
            action: #selector(didTapCartButton),
            for: .touchUpInside
        )
        
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(60)
        }
        
        let labelStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 5
            $0.alignment = .leading
            $0.distribution = .fill
        }

        let priceNameLabel = UILabel(text: "총 금액", config: .priceNameLabel)
        priceLabel.apply(.priceLabel)
        priceLabel.text = priceCount
        
        labelStackView.addArrangedSubview(priceNameLabel)
        labelStackView.addArrangedSubview(priceLabel)
        
        stackView.addArrangedSubview(labelStackView)
        stackView.addArrangedSubview(shoppingCartButton)
    }
    
    @objc private func didTapCartButton() {
        onTapCartButton?()
    }
}
