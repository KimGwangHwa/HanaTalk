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
    
    var isBlank: Bool {
        return self.isEmpty
    }
    
    
    func date(format: DateTemplate) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
    
    
}

extension Optional where Wrapped == String {
    var isBlank: Bool {
        return self?.isBlank ?? true
    }
}
