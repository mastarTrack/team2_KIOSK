//
//  MenuView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/3/26.
//
import Foundation
import UIKit
// 스크롤 뷰 만들기
// 버튼 스택 뷰 만들기
class MenuSectionView: UIView {
    let menuSection = ["시즌메뉴", "커피", "디카페인", "라떼", "논커피", "스무디", "쥬스", "디저트"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        let contentView = UIView()
    }
}

