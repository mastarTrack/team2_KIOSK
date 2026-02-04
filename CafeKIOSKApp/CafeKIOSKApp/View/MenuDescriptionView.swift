//
//  MenuDescriptionView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/4/26.
//

import UIKit
import SnapKit
import Then

/// 메뉴 상세화면 용 메뉴 설명 뷰
class MenuDescriptionView: UIView {
    
    // MARK: - Componants
    let menuImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let menuTitleLabel = UILabel().then {
        $0.font = LabelConfiguration.descriptionTitle.font
        $0.textColor = LabelConfiguration.descriptionTitle.color
        $0.numberOfLines = LabelConfiguration.descriptionTitle.lines
        $0.textAlignment = .center
    }
    
    let menuIceOrHotLabel = UILabel().then {
        $0.font = LabelConfiguration.descriptionText.font
        $0.textColor = .black
        $0.numberOfLines = LabelConfiguration.descriptionText.lines
        $0.textAlignment = .center
    }
    
    let MenuDescriptionLabel = UILabel().then {
        $0.font = LabelConfiguration.descriptionText.font
        $0.textColor = LabelConfiguration.descriptionText.color
        $0.numberOfLines = LabelConfiguration.descriptionText.lines
        $0.textAlignment = .center
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        SetTempData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - METHOD: Set UI Data
extension MenuDescriptionView {
    /// 메뉴 정보 설정 메소드
    func setUIData(_ image: UIImage,_ title: String,_ iceHot: String,_ text: String) {
        menuImageView.image = image
        menuTitleLabel.text = title
        menuIceOrHotLabel.attributedText = makeColorToIceAndHot(text: iceHot)
        MenuDescriptionLabel.text = text
    }
}

//MARK: - METHOD: TEST
extension MenuDescriptionView {
    /// 테스트 메소드
    private func SetTempData() {
        menuImageView.image = .caramelMacchiato
        menuTitleLabel.text = "카라멜 마끼아또"
        menuIceOrHotLabel.attributedText = makeColorToIceAndHot(text:"ICE | HOT")
        MenuDescriptionLabel.text = "카라멜 마끼아또는 부드러운 스팀 우유와 에스프레소, 바닐라 시럽을 섞은 후 달콤한 카라멜 소스를 드리즐(지그재그로 뿌림)하여 만든 달달하고 부드러운 커피 음료"
    }
}

//MARK: - UI Setting
extension MenuDescriptionView {
    /// UI 초기 설정 메소드
    private func configureUI() {
        let stackView = UIStackView().then{
            $0.axis = .vertical
            $0.distribution = .fill
            $0.spacing = 20
            $0.alignment = .center
            }
        
        stackView.addArrangedSubview(menuImageView)
        stackView.addArrangedSubview(menuTitleLabel)
        stackView.addArrangedSubview(menuIceOrHotLabel)
        stackView.addArrangedSubview(MenuDescriptionLabel)
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints{
            $0.directionalEdges.equalToSuperview()
        }
        
        menuImageView.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(300)
        }
        
        menuTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        menuIceOrHotLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        MenuDescriptionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}


#Preview {
    MenuDescriptionView()
}
