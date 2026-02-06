//
//  optionCheckCell.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/6/26.
//

import UIKit
import Then
import SnapKit

class optionCheckCell : UICollectionViewCell {
    
    static let identifier = "CheckCell"
    
    let optionCheckView = MenuOptionCheckView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(optionCheckView)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


extension optionCheckCell {
    func configUI() {
        optionCheckView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview()
        }
    }
}

#Preview {
    optionCheckCell()
}
