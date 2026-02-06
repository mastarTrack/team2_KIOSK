//
//  MainMenuViewController.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/5/26.
//

import UIKit
import SnapKit

// 페이지 컨트롤 설정
//콜렉트뷰에 정보 넣기 ㅎㅎ
class MainMenuViewController: UIViewController {
    let mainMenuViewModel = MainMenuViewModel()
    let cartModel = CartManager()
    
    let mainMenuSectionView = MainMenuSectionView()
    let mainBottomView = MainBottomView()
    let mainMenuCollectionView = MainMenuCollectionView()
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .red
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainMenuCollectionView.changeToCurrentPage = { [weak self] page in
            self?.pageControl.currentPage = page
        }
        

        firstUpdate() // 함수 등록
        changeCategory()
        passSelectedItem()
        
        configure()
        
        mainMenuViewModel.loadMenu()
    }
    
    func changeCategory() {
        mainMenuSectionView.tapCategory = { [weak self] category in
            guard let self else { return }
            mainMenuViewModel.selectedCategory = category
            self.mainMenuCollectionView.update(
                selectedCategoryId: self.mainMenuViewModel.selectedCategory,
                itemsByCategoryId: self.mainMenuViewModel.itemsByCategoryId
            )
        }
    }
    
    // 함수 등록
    func firstUpdate() {
        // 뷰모델에서 oneTimeUpdate 호출하면 아래에 있는 함수 실행됨
        
        mainMenuViewModel.oneTimeUpdate = { [weak self] in
            guard let self else { return }
            self.mainMenuSectionView.setupButtons(categories: self.mainMenuViewModel.categories)
            // 콜렉션뷰 첫화면 나타내기
            self.mainMenuCollectionView.update(selectedCategoryId: self.mainMenuViewModel.selectedCategory, itemsByCategoryId: self.mainMenuViewModel.itemsByCategoryId)
        }
    }
    
    func passSelectedItem() {
        mainMenuCollectionView.selectedItem = { item in // <여기서 전달 받습니당
            // 여기에 주헌님 뷰컨 생성해서 네비게이션 바에 이런식으로 넣어주면 됩니다 👍
            // let detailVC = DetailViewController(item: item, cartModel: CartModel) 선택된 아이템과 카트모델 같이 보내줍니다
            // navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    func configure() {
        view.addSubview(mainMenuSectionView)
        view.addSubview(mainBottomView)
        view.addSubview(mainMenuCollectionView)
        view.addSubview(pageControl)
        
        mainMenuSectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.trailing.leading.equalToSuperview()
        }
        
        mainMenuCollectionView.snp.makeConstraints {
            $0.top.equalTo(mainMenuSectionView.snp.bottom)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(pageControl.snp.top)
        }
        
        pageControl.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.bottom.equalTo(mainBottomView.snp.top)
            $0.trailing.leading.equalTo(mainBottomView)
        }
        
        mainBottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalToSuperview()
        }
    }
}

