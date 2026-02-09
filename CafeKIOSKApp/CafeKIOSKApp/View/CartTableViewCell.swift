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
    
    // MARK: -- 클로저
    // 삭제 버튼 클로저 지정
    var removeAction: (() -> Void)?
    
    // 증감 버튼 클로저 정의
    var plusAction: (() -> Void)?
    var minusAction: (() -> Void)?
    
    // 체크버튼 클로저 지정
    var checkAction: (() -> Void)?
    
    
    // MARK: -- UI 요소 만들기
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
    
    private let temperatureLabel = UILabel().then {
        $0.text = "1"
        $0.font = .systemFont(ofSize: 13)
        $0.textAlignment = .center
    }
    
    private let shotLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemGray
    }
    
    // 삭제 버튼 구현
    private let deleteButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 13, weight: .regular)
        // SF symbol
        let image = UIImage(systemName: "xmark",  withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemGray
    }
    
    // 체크 버튼 구현
    private let checkBox = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .bold)
        let image = UIImage(systemName: "checkmark.circle.fill",  withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemYellow
    }
    
    // 감소 버튼 구현
    private let minusButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "minus.square",  withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemGray2
    }
    
    // 증가 버튼 구현
    private let plusButton = UIButton().then {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        let image = UIImage(systemName: "plus.square",  withConfiguration: config)
        $0.setImage(image, for: .normal)
        $0.tintColor = .systemGray
    }
    
    // MARK: -- 초기화
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        // 버튼 액션 연결
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchDown)
        checkBox.addTarget(self, action: #selector(checkTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -- 클로저 연결
    @objc func deleteTapped() {
        removeAction?()
    }
    
    @objc func checkTapped() {
        checkAction?()
    }
    
    @objc func minusTapped() {
        minusAction?()
    }
    
    @objc func plusTapped() {
        plusAction?()
    }
    
    // MARK: -- addSubView, AutoLayout
    private func setupUI() {
        // addSubView
        [imgView, nameLabel, priceLabel, countLabel, temperatureLabel, shotLabel, deleteButton, checkBox, minusButton, plusButton].forEach {
            contentView.addSubview($0)
        }
        
        // AutoLayout
        // 이미지뷰 배치
        imgView.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.bottom.equalTo(contentView).inset(10)
            $0.leading.equalToSuperview().inset(35)
            $0.width.height.equalTo(70)
        }
        
        // 메뉴 이름 배치
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imgView.snp.trailing).offset(20)
            $0.centerY.equalTo(checkBox)
        }
        
        // 가격 배치
        priceLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(imgView.snp.bottom).inset(5)
        }
        
        // 개수 배치
        countLabel.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(minusButton.snp.trailing).offset(15)
        }
        
        // 온도 라벨 배치
        temperatureLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(3)
        }
        
        // 샷수 라벨
        shotLabel.snp.makeConstraints {
            $0.leading.equalTo(temperatureLabel.snp.leading)
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(3)
        }
        
        // 삭제 버튼 배치
        deleteButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(3)
            $0.trailing.equalToSuperview().inset(15)
            $0.width.height.equalTo(30)
        }
        
        // 마이너스 버튼 배치
        minusButton.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(imgView.snp.trailing).offset(20)
        }
        
        // 마이너스 버튼 배치
        plusButton.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(countLabel.snp.trailing).offset(15)
        }
        
        // 체크표시 버튼
        checkBox.snp.makeConstraints {
            $0.trailing.equalTo(imgView.snp.leading)
            $0.top.equalTo(contentView).inset(5)
            $0.width.height.equalTo(30)
        }
    }
    
    // MARK: -- 데이터 채워넣는 함수
    func configure(with item: CartItem) {
        nameLabel.text = item.menu.name
        
        priceLabel.text = "\(formatAsCurrency(intMoney: (item.menu.price + (item.menu.options.extraShot?.pricePerShot ?? 0 * item.shotCount)) * item.count))원"
        
        countLabel.text = "\(item.count)"
        
        let url = URL(string: item.menu.imageUrl)
        imgView.kf.setImage(with: url)
        
        // 온도 데이터 채워넣기
        if let temps = item.menu.options.temperature, !temps.isEmpty {
            // HOT, ICE에 따라 색상 변경
            temperatureLabel.isHidden = false
            if item.isIce {
                temperatureLabel.text = "ICE"
                temperatureLabel.textColor = .systemBlue
            } else {
                temperatureLabel.text = "HOT"
                temperatureLabel.textColor = .systemRed
            }
        } else {
            // 온도 옵션이 없는 메뉴는 숨김
            temperatureLabel.isHidden = true
        }
        
        // 샷 데이터 채워넣기
        let shots = item.shotCount
        if shots > 0 {
            shotLabel.isHidden = false
            shotLabel.text = "\(item.shotCount)샷 추가(+\(item.menu.options.extraShot?.pricePerShot ?? 0 * item.shotCount)원)"
        } else {
            // 샷추가 하지않은 메뉴는 숨김
            shotLabel.isHidden = true
        }
        
        // 체크박스 연결하기
        checkBox.isSelected = item.isSelected!
        
        if item.isSelected! {
            self.checkBox.tintColor = .systemYellow
        } else {
            self.checkBox.tintColor = .systemGray4
        }
    }
    
}

