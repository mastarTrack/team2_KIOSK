//
//  CartView.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/6/26.
//

import UIKit
import Then
import SnapKit

class CartView: UIView {
    
    // MARK: -- 상단, 테이블, 하단 뷰 선언
    // 1. 상단 뷰 (타이틀, 위치)
    let topView = CartTopView()
    
    // 2. 테이블 뷰 (메뉴 목록)
    let tableView = UITableView().then {
        $0.rowHeight = 120 // 셀 높이
        $0.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
    }
    
    // 3. 하단 버튼 뷰
    let bottomView = CartBottomView()
    
    
    // MARK: -- 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -- 뷰 위치 잡기
    private func setupUI() {
        // addSubview
        [topView, tableView, bottomView].forEach {
            addSubview($0)
        }
        
        // 상단뷰 위치 잡기
        topView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        // 테이블뷰 위치 잡기
        tableView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(topView.snp.bottom)
            $0.bottom.equalTo(bottomView.snp.top)
        }
        
        // 하단의 버튼 뷰
        bottomView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(110)
        }
    }
}

#Preview {
    UINavigationController(rootViewController: CartViewController())
}

