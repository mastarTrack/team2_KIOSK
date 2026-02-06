//
//  TempCell.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/6/26.
//

import UIKit
import Then
import SnapKit

class optionIceHotCell : UICollectionViewCell {
    
    static let identifier = "IceHotCell"
    
    let optionIceHotView = MenuIceHotView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(optionIceHotView)
        configUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        optionIceHotView.updateSelected(isIce: true)
    }
}


extension optionIceHotCell {
    func configUI() {
        optionIceHotView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(10)
            $0.width.equalToSuperview()
        }
    }
}

#Preview {
    optionIceHotCell()
}
