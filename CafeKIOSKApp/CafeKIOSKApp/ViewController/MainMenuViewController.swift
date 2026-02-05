//
//  MainMenuViewController.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/5/26.
//

import UIKit
import SnapKit

class MainMenuViewController: UIViewController {
    
    let header = MainMenuSectionView()
    let myBottomView = MainBottomView()
    let myCV = MainMenuCollectionView()
    
    //let items = Array(0..<10)
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        
        myCV.changeToCurrentPage = { [weak self] page in
            self?.pageControl.currentPage = page
        }
    }
    
    func configure() {
        view.addSubview(header)
        view.addSubview(myBottomView)
        view.addSubview(myCV)
        view.addSubview(pageControl)
        
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.leading.equalToSuperview()
        }
        
        myCV.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControl.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.bottom.equalTo(myBottomView.snp.top)
            $0.trailing.leading.equalTo(myBottomView)
        }
        
        myBottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
        }
    }
}

