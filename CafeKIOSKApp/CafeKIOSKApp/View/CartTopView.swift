//
//  CartTopView.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/6/26.
//

import UIKit
import SnapKit
import Then

class CartTopView: UIView {
    
    // 주문하기 라벨
    private let cartTopLabel = UILabel().then {
        $0.backgroundColor = .systemBackground
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 22, weight: .medium)
        $0.textAlignment = .center
        $0.text = "주문하기"
    }
    
    // 위치 나타내는 부분 뷰
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
    
    // 위치 라벨
    private let locationLabel = UILabel().then {
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.text = "칼퇴커피 1호점"
    }
    
    // 전체선택 체크 버튼 구현
    private let totalCheckButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
        let image = UIImage(systemName: "checkmark.circle.fill",  withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemGray4
    }
    
    
    // 전체선택 텍스트 라벨
    private let totalLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        totalCheckButton.addTarget(self, action: #selector(didTapSelectAll), for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 뷰컨한테 버튼 눌렸다고 전하는 심부름꾼 클로저
    var selectAllAction: (() -> Void)?

    @objc private func didTapSelectAll() {
        selectAllAction?()
    }
    
    func updateStatus(selectedCount: Int, totalCount: Int) {
        let text = "전체선택 \(selectedCount)/\(totalCount)"
        
        totalLabel.text = text
        
        let isAllSelected = (totalCount > 0) && (selectedCount == totalCount)
        
        
        totalCheckButton.isSelected = isAllSelected
        
        if isAllSelected {
            totalCheckButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            totalCheckButton.tintColor = .systemYellow
        } else {
            totalCheckButton.tintColor = .systemGray4
        }
    }
    
    
    // UI설정
    private func setupUI() {
        self.backgroundColor = .white
        
        self.addSubview(cartTopLabel)
        self.addSubview(locationView)
        self.addSubview(totalCheckButton)
        self.addSubview(totalLabel)
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
            $0.leading.equalToSuperview().inset(23)
            $0.centerY.equalToSuperview()
        }
        
        totalCheckButton.snp.makeConstraints {
            $0.top.equalTo(locationView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(26)
        }
        
        totalLabel.snp.makeConstraints {
            $0.leading.equalTo(totalCheckButton.snp.trailing).offset(4)
            $0.centerY.equalTo(totalCheckButton)
        }
    }
}

#Preview {
    CartViewController()
}
