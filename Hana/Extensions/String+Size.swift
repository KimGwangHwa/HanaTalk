//
//  String+Size.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/05.
//

import Foundation
import UIKit

extension String {
    func size(with minHeight: CGFloat, font: UIFont) -> CGSize {
        
        let textSize = NSString(string: self).size(withAttributes: [NSAttributedStringKey.font: font])
        let textWidth = ceil(textSize.width)
        
        return CGSize(width: textWidth < minHeight ? minHeight : textWidth , height: minHeight)
    }
}
