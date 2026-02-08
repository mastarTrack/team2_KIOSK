//
//  MenuOptionViewController.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/6/26.
//

import UIKit
import SnapKit
import Then

class MenuOptionViewController: UIViewController {
    
    //MARK: - ViewModel
    private let viewModel: MenuOptionViewModel
    
    //MARK: - Components
    private var collectionView: UICollectionView!
    
    private let menuOrderView = MenuOptionOrderView()
    
    //MARK: - Init
    init(menu: MenuItem, cartManager: CartManager) {
        viewModel = MenuOptionViewModel(cartManager: cartManager, menuItem: menu)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        let menu = CartItem.SetSampleData()
        let cartManager = CartManager()
        self.init(menu: menu.menu, cartManager: cartManager)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "옵션 선택"

        configureUI()
        setOrderViewClosures()
    }
}

//MARK: - OrderView Related Methods
extension MenuOptionViewController {
    /// orderView 클로져 세팅 메소드
    func setOrderViewClosures(){
        // 개수 버튼 클로져 설정
        menuOrderView.orderCountButtonClosure = { [weak self] action in
            guard let self else { return }
            viewModel.updateMenuCount(action: action)
            updateOrderUI()
        }
        
        // 주문하기 버튼 클로져 설정
        menuOrderView.orderButtonClosure = { [weak self] in
            guard let self else { return }
            viewModel.commitToCart()
            let cartTableVC = CartTableViewController()
            navigationController?.pushViewController(cartTableVC, animated: true)
        }
        
        // 담기 버튼 클로져 설정
        menuOrderView.returnMainViewBottonClosure = { [weak self] in
            guard let self else { return }
            viewModel.commitToCart()
            navigationController?.popViewController(animated: true)
        }
    }
    
    // orderView UI 갱신 메소드
    func updateOrderUI() {
        menuOrderView.updateOptionUIData(
            count: viewModel.cartItem.count,
            price: "\(formatAsCurrency(intMoney: viewModel.cartItem.getTotalPrice() * viewModel.cartItem.count)) 원")
    }
}

//MARK: - CollectionView Related Methods
extension MenuOptionViewController {
    // 단일 선택 관리 메서드
    private func updateSelectedSize(to indexPath: IndexPath) {
        // 이전 선택 해제
        if let previousIndex = viewModel.selectedSizeIndex,
           let previousCell = collectionView.cellForItem(at: IndexPath(item: previousIndex, section: indexPath.section)) as? optionCheckCell {
            previousCell.optionCheckView.setChecked(false)
        }
        
        // 현재 선택 적용
        if let currentCell = collectionView.cellForItem(at: indexPath) as? optionCheckCell {
            currentCell.optionCheckView.setChecked(true)
        }
        
        // viewModel에 데이터 저장
        viewModel.selectedSizeIndex = indexPath.item
        if let size = viewModel.cartItem.menu.options.size {
            viewModel.cartItem.option?["SIZE"] = [size[indexPath.item] : indexPath.item * 500]
            updateOrderUI()
        }
    }
}

//MARK: - Configure CollectionView
extension MenuOptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// 컬렉션뷰 섹션 설정 메소드
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //TODO: 옵션종류 갯수 설정
        return viewModel.activeSections.count
    }
    
    /// CollectionView의 각 섹션(section)에 몇개를 보여줄지 정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //TODO: 옵션 당 갯수 설정
        let sectionType = viewModel.activeSections[section]
        
        switch sectionType {
        case .mainImage:
            return 1
        case .iceHot:
            return 1
        case .stepper:
            return 1
        case .check:
            return viewModel.cartItem.menu.options.size?.count ?? 0
        }
    }
    
    /// indexPath 위치에 표시할 셀을 생성하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch viewModel.activeSections[indexPath.section] {
        case .mainImage:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionDescriptionCell.identifier,
                for: indexPath
            ) as! optionDescriptionCell
            let iceHotText = viewModel.cartItem.menu.options.temperature?.reversed().joined(separator: " | ") ?? ""
            cell.optionDescriptionView.setUIData(viewModel.cartItem.menu.imageUrl,
                                                 viewModel.cartItem.menu.name,
                                                 iceHotText,
                                                 viewModel.cartItem.menu.description)
            return cell
            
        case .iceHot:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionIceHotCell.identifier,
                for: indexPath
            ) as! optionIceHotCell
            cell.optionIceHotView.updateSelected(isIce: viewModel.cartItem.isIce)
            cell.optionIceHotView.isIceClosure = { [weak self] isIce in
                guard let self else { return }
                viewModel.updateIceHot(isIce: isIce)
            }
            return cell
            
        case .stepper:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionStapperCell.identifier,
                for: indexPath ) as! optionStapperCell
            
            cell.optionStapperView.ButtonActionClosure = { [weak self] action in
                guard let self else { return }
                self.viewModel.updateShotCount(action: action)
                self.updateOrderUI()
            }
            cell.optionStapperView.updateOptionDataUI(
                count: viewModel.cartItem.shotCount,
                price: "+ \(formatAsCurrency(intMoney: viewModel.cartItem.shotCount * (viewModel.cartItem.menu.options.extraShot?.pricePerShot ?? 0))) 원",
                minMax: viewModel.getShotCountState()
            )
            viewModel.shotCountChanged = { [weak self] count, minMax in
                guard let self else { return }
                cell.optionStapperView.updateOptionDataUI(
                    count: count,
                    price: "+ \(formatAsCurrency(intMoney: count * (viewModel.cartItem.menu.options.extraShot?.pricePerShot ?? 0))) 원",
                    minMax: minMax
                )
            }
            return cell
            
        case .check:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionCheckCell.identifier, for: indexPath) as! optionCheckCell
            
            if let size = viewModel.cartItem.menu.options.size {
                let isChecked = (viewModel.selectedSizeIndex == indexPath.item)
                
                cell.optionCheckView.setUIData(
                    title: size[indexPath.item],
                    price: "+ \(formatAsCurrency(intMoney: indexPath.item * 500)) 원",
                    checked: isChecked
                )
                
                // Closure 전달
                cell.didTapCheck = { [weak self] in
                    guard let self = self else { return }
                    self.updateSelectedSize(to: indexPath)
                }
            }
            return cell
        }
    }
}


//MARK: - METHOD: Config CompositionalLayout
extension MenuOptionViewController {
    /// 섹션타입에 따른 레이아웃 생성 메소드
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let MenuSectionType = self.viewModel.activeSections[sectionIndex]
            
            switch MenuSectionType {
            case .mainImage:
                return DesriptionSection()
            case .iceHot:
                return iceHotSection()
            case .stepper:
                return stepperSection()
            case .check:
                return checkSection()
            }
        }
    }
}

//MARK: - METHOD: CompositionalLayout Settings
extension MenuOptionViewController {
    /// 메뉴 설명 섹션 생성 메소드
    private func DesriptionSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(500)
            )
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(500))
            ,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 9, leading: 0, bottom: 9, trailing: 0)
        
        return section
    }
    
    /// Ice/Hot 옵션 섹션 생성 메소드
    private func iceHotSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1),
                              heightDimension: .absolute(60))
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .estimated(60)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 9, leading: 0, bottom: 9, trailing: 0)
        
        return section
    }
    
    /// 스텝퍼 옵션 섹션 생성 메소드
    func stepperSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(80))
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .estimated(70)),
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 9, leading: 0, bottom: 9, trailing: 0)
        
        return section
    }
    
    /// 체크 옵션 섹션 생성 메소드
    private func checkSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .absolute(60))
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .estimated(60)),
            subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 9, leading: 0, bottom: 9, trailing: 0)
        section.interGroupSpacing = 5
        
        return section
    }
}

//MARK: - METHOD: UI Configure
extension MenuOptionViewController {
    /// 초기 UI 세팅 메소드
    private func configureUI(){
        // 컬랙션뷰 생성
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.register(optionDescriptionCell.self, forCellWithReuseIdentifier: optionDescriptionCell.identifier)
        collectionView.register(optionIceHotCell.self, forCellWithReuseIdentifier: optionIceHotCell.identifier)
        collectionView.register(optionCheckCell.self, forCellWithReuseIdentifier: optionCheckCell.identifier)
        collectionView.register(optionStapperCell.self, forCellWithReuseIdentifier: optionStapperCell.identifier)
        collectionView.dataSource = self
        
        menuOrderView.updateOptionUIData(
            count: viewModel.cartItem.count,
            price: "\(formatAsCurrency(intMoney: viewModel.cartItem.getTotalPrice() * viewModel.cartItem.count)) 원")
        
        view.addSubview(collectionView)
        view.addSubview(menuOrderView)
        collectionView.backgroundColor = .systemGray6
        
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()//.offset(20)
            $0.trailing.equalToSuperview()//.inset(20)
            $0.bottom.equalTo(menuOrderView.snp.top)
        }
        menuOrderView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()//.offset(20)
            $0.trailing.equalToSuperview()//.inset(20)
            $0.height.equalTo(140)
        }
    }
}

#Preview {
    MenuOptionViewController()
}
