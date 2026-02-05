//
//  CartTableViewCell.swift
//  CafeKIOSKApp
//
//  Created by 김주희 on 2/4/26.
//

import UIKit
import SnapKit
import Then
import Kingfisher // url 이미지 변환 패키지

class CartTableViewCell: UITableViewCell {
    
    // 식별자
    static let identifier = "CartTableViewCell"
    
    // 삭제 버튼 클로저 지정
    var removeAction: (() -> Void)?
    
    // UI 요소 만들기
    // 이미지
    private let imgView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .white
    }
    
    // 메뉴 이름
    private let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    // 메뉴 가격
    private let priceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textAlignment = .center
    }
    
    // 개수
    private let countLabel = UILabel().then {
        $0.text = "1"
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textAlignment = .center
    }
    
    private let deleteButton = UIButton().then {
        
        let config = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        // 애플 기본 아이콘 사용
        let image = UIImage(systemName: "xmark",  withConfiguration: config)
        
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemGray2
    }
    
    // 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        // 삭제 버튼 액션 연결
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchDown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func deleteTapped() {
        
        removeAction?()
    }
    
    private func setupUI() {
        [imgView, nameLabel, priceLabel, countLabel,deleteButton].forEach {
            contentView.addSubview($0)
        }
        
        // 이미지 배치
        imgView.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView).inset(10)
            $0.leading.equalToSuperview().inset(35)
            $0.width.height.equalTo(70)
        }
        
        // 삭제 버튼 배치
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.width.height.equalTo(30)
        }
        
        // 메뉴 이름 배치
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(30)
            $0.top.equalTo(imgView.snp.top)
        }
        
        // 가격 배치
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(imgView.snp.bottom).inset(5)
        }
        
        // 개수 배치
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(imgView.snp.trailing).offset(20)
        }
        
        // 체크표시 추가 예정
        
        // 클릭하면 스윽 사라지는것도 하고싶은데 어케할지 아직 모름
    }
    
    
    // 데이터 채워넣는 함수
    func configure(with item: CartItem) {
        nameLabel.text = item.menu.name
        priceLabel.text = "\(item.menu.price * item.count)원"
        countLabel.text = "\(item.count)"
        let url = URL(string: item.menu.imageUrl)
        imgView.kf.setImage(with: url)
    }
    
}
