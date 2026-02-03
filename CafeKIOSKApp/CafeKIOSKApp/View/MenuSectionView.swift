//
//  MenuView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/3/26.
//
import Foundation
import UIKit
import SnapKit

// 스크롤 뷰 만들기
// 버튼 스택 뷰 만들기
class MenuSectionView: UIView {
    let menuSection = ["시즌메뉴", "커피", "디카페인", "라떼", "논커피", "스무디", "쥬스", "디저트"]
    let buttonStackView = UIStackView()
    let scrollView = UIScrollView()
    
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
    
    func makeButtons(title: String) -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.imagePlacement = .leading
        config.imagePadding = 6
        config.cornerStyle = .capsule
        config.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        let button = UIButton(configuration: config)
        return button
    }
    
    func setupButtons() {
        menuSection.enumerated().forEach { index, menuSection in
            let button = makeButtons(title: menuSection)
            
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    func configure() {
        let contentView = UIView()
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 20
        buttonStackView.alignment = .center
        buttonStackView.distribution = .fill
        
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

