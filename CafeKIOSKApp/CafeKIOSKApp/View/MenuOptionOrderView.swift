//
//  MenuOptionOrderView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/5/26.
//


import UIKit
import SnapKit
import Then
  
class MenuOptionOrderView: UIView {
    
    // MARK: - Closures
    /// 메뉴 개수 증가 버튼 이벤트용 클로져
    var orderIncreaseCountClosure: (()->Void)?
    /// 메뉴 개수 감소 버튼 이벤트용 클로져
    var orderDecreaseCountClosure: (()->Void)?
    /// 담기 버튼 이벤트용 클로져
    // TODO: 메인뷰에 전달할 모델값으로 수정 예정
    var cartCartClosure: (()->Void)?
    /// 주문하기 버튼 이벤트용 클로져
    // TODO: 결제뷰에 전달할 모델값으로 수정 예정
    var orderCartClosure: (()->Void)?
    
    
    // MARK: - Components
    /// 갯수 레이블
    let countLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .center
    }
    /// 전체금액 레이블
    let TotalPriceLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    /// 개수 증가버튼
    let increaseButton = UIButton(configuration: .filled()).then {
        var attr = AttributeContainer()
        attr.font = UIFont.boldSystemFont(ofSize: 20)
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets()
        $0.configuration?.attributedTitle = AttributedString("+", attributes: attr)
        $0.configuration?.baseBackgroundColor = .systemBlue
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.cornerStyle = .fixed
        $0.configuration?.titleAlignment = .center
        $0.configuration?.background.cornerRadius = 15
    }
    
    /// 개수 감소버튼
    let decreaseButton = UIButton(configuration: .filled()).then {
        var attr = AttributeContainer()
        attr.font = UIFont.boldSystemFont(ofSize: 20)
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets()
        $0.configuration?.attributedTitle = AttributedString("-", attributes: attr)
        $0.configuration?.baseBackgroundColor = .systemRed
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.cornerStyle = .fixed
        $0.configuration?.titleAlignment = .center
        $0.configuration?.background.cornerRadius = 15
    }
    
    /// 담기 버튼
    let cartButton = UIButton(configuration: .filled()).then {
        var attr = AttributeContainer()
        attr.font = UIFont.boldSystemFont(ofSize: 20)
        $0.configuration?.contentInsets = .zero
        $0.configuration?.attributedTitle = AttributedString("담기", attributes: attr)
        $0.configuration?.baseBackgroundColor = .systemGray
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.cornerStyle = .fixed
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        $0.clipsToBounds = true
    }
    
    /// 주문하기 버튼
    let orderButton = UIButton(configuration: .filled()).then {
        var attr = AttributeContainer()
        attr.font = UIFont.boldSystemFont(ofSize: 20)
        $0.configuration?.contentInsets = .zero
        $0.configuration?.attributedTitle = AttributedString("주문하기", attributes: attr)
        $0.configuration?.baseBackgroundColor = .systemYellow
        $0.configuration?.baseForegroundColor = .white
        $0.configuration?.cornerStyle = .fixed
        $0.layer.cornerRadius = 15
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        $0.clipsToBounds = true
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        SetButtonAction()
        setSampleData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MenuOptionOrderView Error")
    }
    
}

//MARK: - METHOD: SET ButtonAction
extension MenuOptionOrderView {
    private func SetButtonAction() {
        increaseButton.addAction(UIAction { [weak self] _ in
            self?.orderIncreaseCountClosure?()
        }, for: .touchUpInside)
        
        decreaseButton.addAction(UIAction { [weak self] _ in
            self?.orderDecreaseCountClosure?()
        }, for: .touchUpInside)
        
        cartButton.addAction(UIAction{ [weak self] _ in
            self?.cartCartClosure?()
        }, for: .touchUpInside)
        orderButton.addAction(UIAction { [weak self] _ in
            self?.orderCartClosure?()
        }, for: .touchUpInside)
    }
    
    func updateOptionUIData(count: Int, price: String) {
        countLabel.text = "\(count)"
        TotalPriceLabel.text = price
    }
}

//MARK: - METHOD: UI SETTING
extension MenuOptionOrderView {
    /// 초기 UI 설정
    private func configureUI() {
        let mainStack = UIStackView().then {
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 2
            $0.layer.borderWidth = 1
        }
        let topStack = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 5
        }
        let bottomStack = UIStackView().then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 5
        }
        
        topStack.addArrangedSubview(increaseButton)
        topStack.addArrangedSubview(countLabel)
        topStack.addArrangedSubview(decreaseButton)
        topStack.addArrangedSubview(TotalPriceLabel)
        
        let emptyView  = UIView()
        
        bottomStack.addArrangedSubview(emptyView)
        bottomStack.addArrangedSubview(cartButton)
        bottomStack.addArrangedSubview(orderButton)
        
        mainStack.addArrangedSubview(topStack)
        mainStack.addArrangedSubview(bottomStack)
        
        addSubview(mainStack)
        
        mainStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(80)
            $0.width.lessThanOrEqualToSuperview()
        }
        
        increaseButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        decreaseButton.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        countLabel.snp.makeConstraints {
            $0.width.height.equalTo(40)
        }
        TotalPriceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
        }
        cartButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
        orderButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
}

//MARK: - METHOD: UI SAMPLE
extension MenuOptionOrderView {
    func setSampleData() {
        countLabel.text = "2"
        TotalPriceLabel.text = "14,000 원"
    }

}




#Preview {
    MenuOptionOrderView()
}
