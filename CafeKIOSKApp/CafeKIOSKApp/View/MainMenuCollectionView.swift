//
//  MainMenuCollectionView.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/4/26.
//
import Foundation
import UIKit
import SnapKit
import Then

// UICollectionViewDataSource - 셀 개수 셀 내용 제공을 이 뷰가 직접하겠음
class MainMenuCollectionView: UIView {
    let dataManager = CoffeeMenuDataService()
    var menuData = [MenuItem]()
    
    lazy var collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: makeLayout()
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
        
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        collectionView.dataSource = self
        configure()
        
        dataManager.loadMenu { result in
            switch result {
            case .success(let menuData):
                self.menuData = menuData.items
                
            case .failure(let error):
                print("에러발생: \(error)")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        collectionView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
    }
    
    func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            let spacing: CGFloat = 10
            
            let containerSize = environment.container.effectiveContentSize
            let itemWidthSize = (containerSize.width - spacing * 4) / 3
            let itemHeightSize = (containerSize.height - spacing * 4) / 3
            
            let item = NSCollectionLayoutItem(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(itemWidthSize),
                heightDimension: .absolute(itemHeightSize)
              )
            )
            
            let rowGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute((itemWidthSize * 3)),
                    heightDimension: .absolute(itemHeightSize)
                ),
                repeatingSubitem: item,
                count: 3
            )
            
            rowGroup.interItemSpacing = .fixed(spacing)
            
            let gridGroup = NSCollectionLayoutGroup.vertical(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
              ),
              repeatingSubitem: rowGroup,
              count: 3
            )
            
            gridGroup.interItemSpacing = .fixed(spacing)
            gridGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)

            let section = NSCollectionLayoutSection(group: gridGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        })
    }
    
}

extension MainMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: GridCell.identifier,
            for: indexPath) as? GridCell else {
            print("셀오류")
            return UICollectionViewCell()
        }
        return cell
    }
}


class GridCell: UICollectionViewCell {
    static let identifier = "GridCell"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 컨텐트 뷰에 넣음
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.trailing.bottom.top.greaterThanOrEqualTo(8)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        label.text = text
    }
}
