//
//  MenuIceHotView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/5/26.
//

import UIKit
import SnapKit
import Then

class MenuIceHotView : UIStackView {
    
    //MARK: - Closures
    /// Ice 상태 변화 전달 클로져
    var isIceClosure: ((Bool) -> Void)?
    
    //MARK: - Components
    /// 아이스 선택 버튼
    let iceButton = UIButton(configuration: .filled()).then {
        $0.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.background.strokeColor = .systemBlue
            if button.isSelected {
                config?.baseBackgroundColor = .white
                config?.baseForegroundColor = .systemBlue
                config?.background.strokeWidth = 5
            } else {
                config?.baseBackgroundColor = .systemBlue
                config?.baseForegroundColor = .white
                config?.background.strokeWidth = 0
            }
            var attr = AttributeContainer()
            attr.font = UIFont.boldSystemFont(ofSize: 30)
            config?.attributedTitle = AttributedString("ICE", attributes: attr)
            config?.titleAlignment = .center
            config?.background.cornerRadius = 0
            config?.cornerStyle = .fixed
            button.configuration = config
            button.layer.cornerRadius = 0
            button.clipsToBounds = true
        }
    }
    /// 핫 선택 버튼
    let hotButton = UIButton(configuration: .filled()).then {
        $0.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.background.strokeColor = .systemRed
            if button.isSelected {
                config?.baseBackgroundColor = .white
                config?.baseForegroundColor = .systemRed
                config?.background.strokeWidth = 5
            } else {
                config?.baseBackgroundColor = .systemRed
                config?.baseForegroundColor = .white
                config?.background.strokeWidth = 0
            }
            var attr = AttributeContainer()
            attr.font = UIFont.boldSystemFont(ofSize: 30)
            config?.attributedTitle = AttributedString("HOT", attributes: attr)
            config?.titleAlignment = .center
            config?.background.cornerRadius = 0
            config?.cornerStyle = .fixed
            button.configuration = config
            button.layer.cornerRadius = 0
            button.clipsToBounds = true
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setButtonAction()
        iceButton.isSelected = true
    }
    required init(coder: NSCoder) {
        fatalError("MenuIceHotView Error")
    }
}
//MARK: - METHOD: SET BUTTON ACTION
extension MenuIceHotView {
    /// 버튼 액션 추가 메소드
    private func setButtonAction() {
        iceButton.addAction(UIAction { [weak self] _ in self?.updateSelected(isIce: true) }, for: .touchUpInside)
        hotButton.addAction(UIAction { [weak self] _ in self?.updateSelected(isIce: false) }, for: .touchUpInside)
    }
    
    
    @objc
    /// 버튼 선택에 대한 UI 활성화 변화 액션 메소드
    func updateSelected(isIce: Bool) {
        iceButton.isSelected = isIce
        hotButton.isSelected = !isIce
        isIceClosure?(isIce)
    }
}

//MARK: - METHOD: UI SETTING
extension MenuIceHotView {
    /// UI 초기 설정 메소드
    private func configureUI() {
        axis = .horizontal
        alignment = .center
        distribution = .fillEqually
        
        addArrangedSubview(iceButton)
        addArrangedSubview(hotButton)
    }
}

#Preview {
    MenuIceHotView()
}
