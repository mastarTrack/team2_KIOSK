//
//  MenuView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/3/26.
//
import Foundation
import UIKit
import SnapKit

class MenuSectionView: UIView {
    let menuSection = ["시즌메뉴 - 대박 이때만 맛볼 수 있는 메뉴", "커피", "디카페인", "라떼", "논커피", "스무디", "쥬스", "디저트"]
    let buttonStackView = UIStackView()
    let scrollView = UIScrollView()
    var menuButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(scrollView)
        
        setupButtons()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtons() {
        menuSection.enumerated().forEach { index, menuSection in
            let button = UIButton(title: menuSection)
            button.tag = index
            
            button.addAction(UIAction { [weak self, weak button] _ in
                guard let self, let selectedButton = button else { return }
                
                for button in self.menuButtons {
                    let isSameButton = (button === selectedButton)
                    button.isSelected = isSameButton
                    button.setNeedsUpdateConfiguration()
                }
            }, for: .touchUpInside)
            
            menuButtons.append(button)
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    func configure() {
        let contentView = UIView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fillProportionally
        
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.addSubview(contentView)
        contentView.addSubview(buttonStackView)
        
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            $0.bottom.top.equalTo(scrollView.frameLayoutGuide)
        }
                
        buttonStackView.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(30)
            $0.trailing.equalTo(contentView).offset(-30)
            $0.top.bottom.equalTo(contentView)
        }
    }
}

