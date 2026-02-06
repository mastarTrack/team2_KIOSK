//
//  optionStapperCell.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/6/26.
//

import UIKit
import Then
import SnapKit

class optionStapperCell : UICollectionViewCell {
    
    static let identifier = "StapperCell"
    
    let optionStapperView = MenuOptionStapperView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(optionStapperView)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


extension optionStapperCell {
    func configUI() {
        optionStapperView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview()
        }
    }
}

#Preview {
    optionStapperCell()
}
