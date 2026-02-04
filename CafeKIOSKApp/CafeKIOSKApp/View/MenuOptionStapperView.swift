//
//  MenuOptionStapperView.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/4/26.
//

import UIKit
import Then
import SnapKit

class MenuOptionStapperView: UIView {
    
    //MARK: - Closures
    var increaseButtonClosure: (()-> Void)?
    var decreaseButtonClosure: (()-> Void)?
    
    //MARK: - Components
    let optionStackView = UIStackView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


#Preview {
    MenuOptionStapperView()
}
