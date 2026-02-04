//
//  StringUtils.swift
//  CafeKIOSKApp
//
//  Created by Hanjuheon on 2/4/26.
//

import Foundation
import UIKit


/// 문자열에서 ICE, HOT 색상을 변경해주는 메소드
func makeColorToIceAndHot(text: String)-> NSAttributedString {
    let attributed = NSMutableAttributedString(string: text)

    if let range = text.range(of: "HOT") {
        let nsRange = NSRange(range, in: text)
        attributed.addAttribute(.foregroundColor, value: UIColor.systemRed, range: nsRange)
    }
    
    if let range = text.range(of: "ICE") {
        let nsRange = NSRange(range, in: text)
        attributed.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: nsRange)
    }
    return attributed
}
