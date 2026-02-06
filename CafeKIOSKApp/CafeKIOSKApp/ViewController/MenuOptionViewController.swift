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
    var activeSections: [MenuSectionType] = []
        
    
    //MARK: Components
    
    //MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeSections.append(.mainImage)
        activeSections.append(.iceHot)
        activeSections.append(.stepper)
        activeSections.append(.check)

        
        // 컬랙션뷰 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        
        collectionView.register(optionDescriptionCell.self, forCellWithReuseIdentifier: optionDescriptionCell.identifier)
        collectionView.register(optionIceHotCell.self, forCellWithReuseIdentifier: optionIceHotCell.identifier)
        collectionView.register(optionCheckCell.self, forCellWithReuseIdentifier: optionCheckCell.identifier)
        collectionView.register(optionStapperCell.self, forCellWithReuseIdentifier: optionStapperCell.identifier)

        
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemGray6
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()//.offset(20)
            $0.trailing.equalToSuperview()//.inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}


//MARK: - Configure CollectionView
extension MenuOptionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    /// 컬렉션뷰 섹션 설정 메솓,
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
            return 1
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
            return cell
            
        case .iceHot:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionIceHotCell.identifier,
                for: indexPath
            ) as! optionIceHotCell
            return cell
        case .check:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionCheckCell.identifier,
                for: indexPath
            ) as! optionCheckCell
            return cell
        case .stepper:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: optionStapperCell.identifier,
                for: indexPath
            ) as! optionStapperCell
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
        
        return section
    }
}


#Preview {
    MenuOptionViewController()
}
