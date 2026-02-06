//
//  MenuOptionStapperView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/4/26.
//

import UIKit
import Then
import SnapKit

/// 메뉴 상세화면 중 스탭방식 옵션 뷰
class MenuOptionStapperView: UIView {
    
    //MARK: - ENUM
    enum MinMax{
        case Min
        case Max
        case None
    }
    
    //MARK: - Closures
    /// 증가 버튼 이벤트용 클로져
    var increaseButtonClosure: (()-> Void)?
    /// 감소 버튼 이벤트용 클로져
    var decreaseButtonClosure: (()-> Void)?
    
    //MARK: - Components
    //. 메인 옵션 스택뷰
    let optionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
        $0.backgroundColor = .white
        $0.alignment = .center
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.2
    }
    /// 옵션 타이틀 라벨
    let optionTitleLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    /// 옵션 금액 라벨
    let optionPriceLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    /// 옵션 개수 라벨
    let optionCountLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = .black
        $0.textAlignment = .center
    }
        
    /// 옵션 개수 증가 버튼
    let increaseButton = UIButton(configuration: .filled()).then {
        var titleattr = AttributeContainer()
        titleattr.font = UIFont.boldSystemFont(ofSize: 15)
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets()
        $0.configuration?.attributedTitle = AttributedString("+", attributes: titleattr)
        $0.configuration?.baseBackgroundColor = .systemBlue
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.cornerStyle = .fixed
        $0.configuration?.titleAlignment = .automatic
        $0.configuration?.background.cornerRadius = 5
    }
    
    /// 옵션 개수 감소 버튼
    let decreaseButton = UIButton(configuration: .filled()).then {
        var titleattr = AttributeContainer()
        titleattr.font = UIFont.boldSystemFont(ofSize: 15)
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets()
        $0.configuration?.attributedTitle = AttributedString("-", attributes: titleattr)
        $0.configuration?.baseBackgroundColor = .systemRed
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.cornerStyle = .fixed
        $0.configuration?.titleAlignment = .automatic
        $0.configuration?.background.cornerRadius = 5
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setTestData()
        SetButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - METHOD: BUTTON ACTION
extension MenuOptionStapperView {
    private func SetButtonAction() {
        increaseButton.addAction(UIAction { [weak self] _ in
            self?.increaseButtonClosure?()
        }, for: .touchUpInside)
        
        decreaseButton.addAction(UIAction { [weak self] _ in
            self?.decreaseButtonClosure?()
        }, for: .touchUpInside)
    }
    
    
    func updateOptionDataUI(count: Int, price: String, minMax: MinMax) {
        optionPriceLabel.text = price
        optionCountLabel.text = "\(count)"
        switch minMax {
        case .Max:
            increaseButton.isEnabled = false
        case .Min:
            decreaseButton.isEnabled = false
        case .None:
            decreaseButton.isEnabled = true
            increaseButton.isEnabled = true
        }
    }
}

//MARK: - METHOD: UI Configure
extension MenuOptionStapperView {
    
    /// UI 초기 설정 메소드
    private func configureUI() {
        let tempView = UIView()
        
        let mainStapperStackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 2
            $0.distribution = .fill
        }
        
        let subStapperStackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 0
            $0.alignment = .center
            $0.distribution = .fill
        }
        subStapperStackView.addArrangedSubview(decreaseButton)
        subStapperStackView.addArrangedSubview(optionCountLabel)
        subStapperStackView.addArrangedSubview(increaseButton)
        mainStapperStackView.addArrangedSubview(optionPriceLabel)
        mainStapperStackView.addArrangedSubview(subStapperStackView)
        optionStackView.addArrangedSubview(optionTitleLabel)
        optionStackView.addArrangedSubview(mainStapperStackView)
        optionStackView.addArrangedSubview(tempView)
        
        addSubview(optionStackView)
        
        optionStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(50)
            $0.width.lessThanOrEqualToSuperview()
        }
        
        optionTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
        }
        
        decreaseButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(27)
        }
        
        increaseButton.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(27)
        }
                
        mainStapperStackView.snp.makeConstraints{
            $0.trailing.equalTo(tempView.snp.leading)
            $0.width.equalTo(90)
        }
        tempView.snp.makeConstraints {
            $0.width.equalTo(20)
        }
    }
}

// MARK: - METHOD: TEST DATA
extension MenuOptionStapperView {
    private func setTestData() {
        optionCountLabel.text = "2"
        optionPriceLabel.text = "+ 500원"
        optionTitleLabel.text = "에스프레소 샷 추가"
    }
}

#Preview {
    MenuOptionStapperView()
}
