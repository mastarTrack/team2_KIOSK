//
//  MenuOptionCheckView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/4/26.
//

import UIKit
import SnapKit
import Then

/// UIButton 혹은 UIControl
class MenuOptionCheckView: UIControl {
    
    // MARK: - Closure
    /// 뷰 터치 제스처에 대한 이벤트 전달용 클로저
    var optionCheckClosure: (() -> Void)?
    
    // MARK: - Components
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
    
    /// 버튼 셀렉트 변수 오버라이딩
    override var isSelected: Bool{
        didSet{
            updateUIData()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        
        configureUI()
        optionStackView.isUserInteractionEnabled = false
        addTarget(self, action: #selector(didTap), for: .touchUpInside)

    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - METHOD: 터치 이벤트 관련
extension MenuOptionCheckView {
    
    /// 버튼 이벤트 메소드
    @objc private func didTap() {
        isSelected.toggle()
        sendActions(for: .valueChanged)
    }
    
    /// 체크값에 따른 이미지 및 배경화면 변경 메소드
    func updateUIData() {
        checkImageView.image = isSelected ? .checked : .unchecked
        optionStackView.backgroundColor = isSelected ? .systemYellow : .white
    }
    
    /// 옵션 타이틀 및 금액 텍스트 설정 메소드
    func setUIData(title: String, price: String, checked: Bool) {
        optionTitleLabel.text = title
        optionPriceLabel.text = price
        isSelected = checked
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
            $0.edges.equalToSuperview()
            $0.height.greaterThanOrEqualTo(40)
            $0.width.lessThanOrEqualToSuperview()
        }
        
        checkImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(25)
            $0.width.height.equalTo(25)
            
        }
        
        tempView.snp.makeConstraints {
            $0.width.equalTo(5)
        }
    }
}

//MARK: - 사용 방법 코드
//optionView.addTarget(
//    self,
//    action: #selector(optionChanged),
//    for: .valueChanged
//)
//@objc private func optionChanged(_ sender: MenuOptionCheckView) {
//    checked = sender.isSelected
//}

#Preview {
    MenuOptionCheckView()
}
