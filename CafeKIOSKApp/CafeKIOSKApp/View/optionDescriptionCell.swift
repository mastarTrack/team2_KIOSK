//
//  DescriptionCell.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/6/26.
//

import UIKit
import Then
import SnapKit

class optionDescriptionCell : UICollectionViewCell {
    
    static let identifier = "DescriptionCell"
    
    let optionDescriptionView = MenuDescriptionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(optionDescriptionView)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


extension optionDescriptionCell {
    func configUI() {
        optionDescriptionView.snp.makeConstraints{
            $0.top.bottom.leading.trailing.equalToSuperview()
            //$0.top.bottom.equalToSuperview().inset(10)
        }
    }
}

#Preview {
    optionDescriptionCell()
}
