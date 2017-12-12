//
//  UIImage.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/13.
//
//

import Foundation
import UIKit

extension UIImage {
    class func colorImage(color: UIColor, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}
