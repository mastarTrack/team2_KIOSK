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
    
    enum MenuSectionType {
        case mainImage
        case iceHot
        case stepper
        case check
    }
    
    //MARK: - Components
    var collectionView: UICollectionView!

    let menuOrderView = MenuOptionOrderView()
    
    //MARK: - Properties
    var activeSections: [MenuSectionType] = []
    
    var selectedSizeIndex: Int? = 0
    
    var tempCartManager = CartManager()

    var menuCart = CartItem(menu: MenuItem(
        id: "menu_001",
        categoryId: "coffee",
        name: "아메리카노",
        nameEn: "Americano",
        description: "에스프레소에 물을 더해 깔끔한 맛의 커피",
        price: 4500,
        imageUrl: "https://img.79plus.co.kr/megahp/manager/upload/menu/20240610105645_1717984605982_8i5CoHU2NV.jpg",
        tags: ["BEST", "HOT", "ICE"],
        options: ItemOptions(
            temperature: ["HOT", "ICE"],
            size: ["TALL", "GRANDE", "VENTI"],
            extraShot: ExtraShot(
                min: 0,
                max: 3,
                pricePerShot: 500
            ),
            iceLevel: ["LESS", "NORMAL", "MORE"]
        ),
        displayOrder: 1
    ),
                            isIce: true,
                            shotCount: 0,
                            count: 0)
    

        
//    //MARK: - Init
//    init(menu: MenuItem, cartManager: CartManager) {
//        self.tempMenu = menu
//        self.tempCartManager = cartManager
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkedNewSection()
        configureUI()
    }
}


//MARK: - Configure CollectionView
extension MenuOptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// 컬렉션뷰 섹션 설정 메소드
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //TODO: 옵션종류 갯수 설정
        return activeSections.count
    }
    
    /// CollectionView의 각 섹션(section)에 몇개를 보여줄지 정하는 메소드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //TODO: 옵션 당 갯수 설정
        let sectionType = activeSections[section]
        
        switch sectionType {
        case .mainImage:
            return 1
        case .iceHot:
            return 1
        case .stepper:
            return 1
        case .check:
            return menuCart.menu.options.size?.count ?? 0
        }
    }
    
    /// indexPath 위치에 표시할 셀을 생성 및 구성하는 메소드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch activeSections[indexPath.section] {
        case .mainImage:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionDescriptionCell.identifier,
                for: indexPath
            ) as! optionDescriptionCell
            
            let iceHotText = menuCart.menu.options.temperature?.reversed().joined(separator: " | ") ?? ""
            cell.optionDescriptionView.setUIData(menuCart.menu.imageUrl,
                                                 menuCart.menu.name,
                                                 iceHotText,
                                                 menuCart.menu.description)
            return cell
            
        case .iceHot:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionIceHotCell.identifier,
                for: indexPath
            ) as! optionIceHotCell
            return cell
            
        case .check:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionCheckCell.identifier, for: indexPath) as! optionCheckCell
            
            if let size = menuCart.menu.options.size {
                let isChecked = (selectedSizeIndex == indexPath.item)
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
            
        case .stepper:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionStapperCell.identifier,
                for: indexPath
            ) as! optionStapperCell
            if let extraSize = menuCart.menu.options.extraShot{
                cell.optionStapperView.updateOptionDataUI(
                    count: menuCart.shotCount,price: "+ \(formatAsCurrency(intMoney: menuCart.shotCount*(extraSize.pricePerShot ?? 0))) 원", minMax: .Min)
            }
            return cell
        }
    }
    
    // 단일 선택 관리 메서드
    private func updateSelectedSize(to indexPath: IndexPath) {
        // 이전 선택 해제
        if let previousIndex = selectedSizeIndex,
           let previousCell = collectionView.cellForItem(at: IndexPath(item: previousIndex, section: indexPath.section)) as? optionCheckCell {
            previousCell.optionCheckView.setChecked(false)
        }

        // 현재 선택 적용
        if let currentCell = collectionView.cellForItem(at: indexPath) as? optionCheckCell {
            currentCell.optionCheckView.setChecked(true)
        }

        selectedSizeIndex = indexPath.item
    }
    
}

//MARK: - METHOD: Config CompositionalLayout
extension MenuOptionViewController {
    /// 섹션타입에 따른 레이아웃 생성 메소드
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            let MenuSectionType = self.activeSections[sectionIndex]

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
    func DesriptionSection() -> NSCollectionLayoutSection {
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
    func iceHotSection() -> NSCollectionLayoutSection {
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
    func checkSection() -> NSCollectionLayoutSection {
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


//MARK: - METHOD: Check Add section
extension MenuOptionViewController {
    func checkedNewSection() {
        activeSections.append(.mainImage)
        if menuCart.menu.options.temperature?.count == 2 {
            activeSections.append(.iceHot)
        }
        if let extraShot = menuCart.menu.options.extraShot {
            if extraShot.max > 0 {
                activeSections.append(.stepper)
            }
        }
        if let size = menuCart.menu.options.size {
            if size.count > 0 {
                activeSections.append(.check)
            }
        }
    }
}

//MARK: - METHOD: UI Configure
extension MenuOptionViewController {
    func configureUI(){
        // 컬랙션뷰 생성
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.register(optionDescriptionCell.self, forCellWithReuseIdentifier: optionDescriptionCell.identifier)
        collectionView.register(optionIceHotCell.self, forCellWithReuseIdentifier: optionIceHotCell.identifier)
        collectionView.register(optionCheckCell.self, forCellWithReuseIdentifier: optionCheckCell.identifier)
        collectionView.register(optionStapperCell.self, forCellWithReuseIdentifier: optionStapperCell.identifier)
        collectionView.dataSource = self
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
