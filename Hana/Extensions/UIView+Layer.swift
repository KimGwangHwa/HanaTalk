//
//  UIView+Layer.swift
//  talk
//
//  Created by ひかりちゃん on 2018/04/03.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return false
        }
        set {
            if newValue {
//                layer.masksToBounds = false
                layer.shadowOffset = CGSize(width: 100, height: 100)
                layer.shadowOpacity = 0.5
                layer.shadowColor = UIColor.yellow.cgColor;
                layer.shadowRadius = 10
            } else {
                layer.shadowColor = UIColor.clear.cgColor;
            }
        }
    }
    
}
