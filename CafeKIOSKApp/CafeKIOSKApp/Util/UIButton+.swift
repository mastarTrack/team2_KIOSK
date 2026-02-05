//
//  UIButton+.swift
//  CafeKIOSKApp
//
//  Created by Yeseul Jang on 2/3/26.
//

import Foundation
import UIKit

extension UIButton {
    func applyCapsule() {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .leading
        config.imagePadding = 6
        config.cornerStyle = .capsule
        config.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)
        
        self.configuration = config
    }
    
    func applyBig() {
        var config = UIButton.Configuration.filled()
        config.imagePlacement = .leading
        config.imagePadding = 6
        config.cornerStyle = .medium
        //config.contentInsets = .init(top: 10, leading: 14, bottom: 15, trailing: 10)
        
        self.configuration = config
    }
    
    
    // 설정시 버튼 액션란에 button.setNeedsUpdateConfiguration() 호출해야 반영됨
    func applySelectedColor(selectedColor: UIColor, baseColor: UIColor) {
        self.configurationUpdateHandler = { button in
            var updatedConfig = button.configuration
            
            if button.isSelected {
                updatedConfig?.baseBackgroundColor = selectedColor
            } else {
                updatedConfig?.baseBackgroundColor = baseColor
            }
            
            button.configuration = updatedConfig
        }
    }
    
    convenience init(title: String, systemImage: String? = nil ) {
        self.init()
        applyCapsule()
        self.configuration?.title = title
        self.configuration?.image = UIImage(systemName: systemImage ?? "")
    }
}
