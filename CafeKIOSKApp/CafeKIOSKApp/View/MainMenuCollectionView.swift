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
import Kingfisher

// UICollectionViewDataSource - 셀 개수 셀 내용 제공을 이 뷰가 직접하겠음
class MainMenuCollectionView: UIView {
    var drinkByCategory = [String: [String]]()
    
    // 페이지 컨트롤러에 넘겨줄 정보 저장
    var changeToCurrentPage: ((Int) -> Void)?
    
    // 콜렉션 뷰 생성
    lazy var collectionView = UICollectionView(
        frame: .zero, //레이아웃 직접 설정을 위해
        collectionViewLayout: makeLayout() // 이 클래스 내에서 다른 메서드 호출하기 때문에 lazy
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(collectionView)
        
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
        collectionView.dataSource = self
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        // 부모뷰 전체에 꽉 채움
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 콜렉션 뷰에 레이아웃을 정하는 메서드 (3*3 그리드)
    func makeLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            let spacing: CGFloat = 10 // 간격
            
            let containerSize = environment.container.effectiveContentSize // 컬렉션뷰가 들어갈 사이즈 자동계산
            let itemWidthSize = (containerSize.width - spacing * 4) / 3 // 들어갈 간격 제외한 아이템 크기 계산
            let itemHeightSize = (containerSize.height - spacing * 4) / 3
            
            let item = NSCollectionLayoutItem( // 아이템 크기 설정
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidthSize),
                    heightDimension: .absolute(itemHeightSize)
                )
            )
            
            // 아이템이 3개 들어가는 한줄(horizontal) 그룹 레이아웃 설정
            let rowGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute((itemWidthSize * 3)),
                    heightDimension: .absolute(itemHeightSize)
                ),
                repeatingSubitem: item, // 아이템을
                count: 3 //3번 넣겠다
            )
            
            rowGroup.interItemSpacing = .fixed(spacing) // 간격줌
            
            // 위의 1줄에 3개 들어가는 그룹을 3개 쌓는(vertical) 그룹 (3*3)
            let gridGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                ),
                repeatingSubitem: rowGroup, // 위의 그룹을
                count: 3 // 3개 쌓음
            )
            
            gridGroup.interItemSpacing = .fixed(spacing)// 안쪽 인스턴스들 간격주기
            // 바깥 쪽에 인셋주기
            gridGroup.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
            
            let section = NSCollectionLayoutSection(group: gridGroup) // 섹션 설정
            section.orthogonalScrollingBehavior = .groupPagingCentered // 스크롤 설정
            
            section.visibleItemsInvalidationHandler =  { [weak self] _, offset, environment in
                guard let self else { return } //weak self라서 해줌
                // 지금 콜렉션뷰 넓이 길이 구하기
                let containerWidthSize = environment.container.effectiveContentSize.width
                
                // 현재 화면이 나타내는 x 좌표 기준으로 화면 크기 나눠주기 (처음에 offset.x는 0, 옆으로 스크롤 하면 +)
                let page = Int((offset.x / containerWidthSize))
                
                // 계산한 현재 페이지 전달
                changeToCurrentPage?(page)
            }
            return section
        })
    }
}

// 데이터 소스 구현 부
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
        cell.layer.shadowColor = UIColor.brown.cgColor
        cell.layer.shadowOpacity = 0.20
        cell.layer.shadowOffset = CGSize(width: 0, height: 4)
        cell.layer.shadowRadius = 4
        cell.layer.masksToBounds = false
        return cell
    }
}

// 확인용 셀
class GridCell: UICollectionViewCell {
    static let identifier = "GridCell"
    
    let drinkImage = UIImageView()
    let label = UILabel()
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 컨텐트 뷰에 넣음
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        
        configure()
        putInfo()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        label.apply(.drinkLabel)
        label.textAlignment = .center
        drinkImage.contentMode = .scaleAspectFill
        drinkImage.clipsToBounds = true
        
        contentView.addSubview(drinkImage)
        contentView.addSubview(label)
        
        drinkImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(drinkImage.snp.width)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(drinkImage.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview().inset(8)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: contentView.layer.cornerRadius
        ).cgPath
    }
    
    func putInfo() {
        let url = URL(string: "https://img.79plus.co.kr/megahp/manager/upload/menu/20251226201136_1766747496618_B9SxVDjAvl.png")
        drinkImage.kf.setImage(with: url)
        label.text = "시즌메뉴 특별 카라멜 마끼야또"
    }
}

/*
 뷰컨에 있어야 하는 페이지뷰 구현 부 - 메인쓰레드에서만 UI 담당하기 때문에..
var pageControl: UIPageControl = {
    let pageControl = UIPageControl()
    pageControl.numberOfPages = 3
    pageControl.currentPage = 0
    pageControl.pageIndicatorTintColor = .gray
    pageControl.currentPageIndicatorTintColor = .black
    return pageControl
}()

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    myCV.changeToCurrentPage = { [weak self] page in
        self?.pageControl.currentPage = page
    }
}
*/
