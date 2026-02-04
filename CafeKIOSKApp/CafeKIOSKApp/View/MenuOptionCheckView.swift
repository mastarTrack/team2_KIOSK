//
//  MenuOptionCheckView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/4/26.
//

import UIKit
import SnapKit
import Then

class MenuOptionCheckView: UIView {
    
    // MARK: - Closure
    /// 뷰 터치 제스처에 대한 이벤트 전달용 클로저
    var optionCheckClosure: (() -> Void)?
    
    // MARK: - Components

    ///
    let optionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
        $0.backgroundColor = .white
        $0.alignment = .center
        $0.layer.cornerRadius = 20
        $0.layer.borderWidth = 0.2
    }
    /// 체크박스 이미지 뷰
    let checkImageView = UIImageView().then {
        $0.image = .unchecked
        $0.contentMode = .scaleAspectFit
    }
    /// 옵션 타이틀 라벨
    let optionTitleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    /// 옵션 금액 라벨
    let optionPriceLabel = UILabel().then {
        $0.numberOfLines = 1
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .right
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setViewTapGesture()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - METHOD: 터치 이벤트 관련
extension MenuOptionCheckView {
    /// 탭 제스쳐 설정 메소드
    func setViewTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc
    /// 탭 동작에 대한 액션 메소드
    func tapAction() {
        optionCheckClosure?()
    }
    
    /// 체크값에 따른 이미지 및 배경화면 변경 메소드
    func reSettingUIData(isCheck: Bool) {
        if isCheck {
            checkImageView.image = .checked
            optionStackView.backgroundColor = .systemYellow
        } else {
            checkImageView.image = .unchecked
            optionStackView.backgroundColor = .white
        }
    }
    
    /// 옵션 타이틀 및 금액 텍스트 설정 메소드
    func setUIData(title: String, price: String) {
        optionTitleLabel.text = title
        optionPriceLabel.text = price
    }
}



//MARK: - METHOD: UI Configure
extension MenuOptionCheckView {
    private func configureUI() {
        
        let tempView = UIView()
    
        optionStackView.addArrangedSubview(checkImageView)
        optionStackView.addArrangedSubview(optionTitleLabel)
        optionStackView.addArrangedSubview(optionPriceLabel)
        optionStackView.addArrangedSubview(tempView)
        
        optionStackView.setCustomSpacing(30, after: optionPriceLabel)
        
        addSubview(optionStackView)
        
        optionStackView.snp.makeConstraints {
            //$0.directionalEdges.equalToSuperview()
            $0.top.leading.equalToSuperview().offset(10)
            $0.bottom.trailing.equalToSuperview().inset(10)
            $0.height.greaterThanOrEqualTo(40)
            $0.width.lessThanOrEqualToSuperview()
            $0.trailing.margins.equalTo(40)
        }
        
        checkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.width.height.equalTo(25)
            $0.centerY.equalToSuperview()
        }
        
        tempView.snp.makeConstraints {
            $0.width.equalTo(5)
        }
    }
}

#Preview {
    MenuOptionCheckView()
}
