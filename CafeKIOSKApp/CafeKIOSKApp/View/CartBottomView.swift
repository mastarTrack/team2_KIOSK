//
//  CartButtonView.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/5/26.
//

import UIKit
import SnapKit
import Then

class CartBottomView: UIView {

    // 주문하기 버튼 클릭시 클로저
    var OrderButtonTapped: (() -> Void)?
    
    // 주문하기 버튼 만들기
    private let orderButton = UIButton().then {
        $0.backgroundColor = .systemYellow
        $0.setTitle("0원 주문하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 10
    }
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        // 버튼 액션 연결
        orderButton.addTarget(self, action: #selector(ButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 버튼 눌림 감지 -> 뷰컨트롤러에 알림
    @objc private func ButtonTapped() {
        OrderButtonTapped?()
    }
    
    // 가격 텍스트를 업데이트하는 메서드
    func updatePrice(_ price: Int) {
        let priceString = formatAsCurrency(intMoney: price)
        orderButton.setTitle("\(priceString)원 주문하기", for: .normal)
    }
    
    // UI설정
    private func setupUI() {
        self.backgroundColor = .white
        
        // 떠있는듯한 그림자 효과
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 4
        
        self.addSubview(orderButton)
        
        orderButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(10)
            $0.bottom.equalToSuperview().inset(30)
        }
    }

}
