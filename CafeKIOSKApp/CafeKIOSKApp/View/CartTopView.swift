//
//  CartTopView.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/6/26.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class CartTopView: UIView {

    private let cartTopLabel = UILabel().then {
        $0.backgroundColor = .systemBackground
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textAlignment = .center
        $0.text = "주문하기"
    }
    
    private let locationView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    // 지도 버튼 구현
    private let mapButton = UIButton().then {
        
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "map", withConfiguration: config)
        
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemGray2
    }
    
    // 위치 라벨ㅋ
    private let locationLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.text = "칼퇴커피 1호점"
    }
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // UI설정
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(cartTopLabel)
        self.addSubview(locationView)
        locationView.addSubview(mapButton)
        locationView.addSubview(locationLabel)
        
        cartTopLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(4)
        }
        
        locationView.snp.makeConstraints {
            $0.top.equalTo(cartTopLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(45)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(mapButton.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }
        
        mapButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}

#Preview {
    CartTableViewController()
}
