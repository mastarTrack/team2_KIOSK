//
//  MainMenuSectionView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/3/26.
//
import Foundation
import UIKit
import SnapKit

//메인 화면 상단 카테고리 화면
class MainMenuSectionView: UIView {
    let buttonStackView = UIStackView()
    var data = [Category]()
    let scrollView = UIScrollView()
    var menuButtons: [UIButton] = []
    let dataManager = CoffeeMenuDataService()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(scrollView)
        
        //데이터 부분
        dataManager.loadMenu { result in
            switch result {
            case .success(let menuData):
                self.data = menuData.categories
                
            case .failure(let error):
                print("에러발생: \(error)")
            }
        }
        
        setupButtons()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 버튼 셋업 및 버튼 하나만 색 바꾸기 로직
    func setupButtons() {
        data.enumerated().forEach { index, category in
            let button = UIButton(title: category.name)
            button.applySelectedColor(selectedColor: .black, baseColor: .brown)
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
    
    // 레이아웃
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

