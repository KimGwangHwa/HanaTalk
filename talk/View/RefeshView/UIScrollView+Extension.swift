//
//  UIScrollView+Extension.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/06.
//

import Foundation
import UIKit

private var headerKey: Void?

extension UIScrollView {
    var refshHeader: RefeshHeader?{
        get{
            return objc_getAssociatedObject(self, &headerKey) as? RefeshHeader
        }set{
            if let header = refshHeader {
                header.removeFromSuperview()
            }
            
            if let new = newValue {
                self.insertSubview(new, at: 0)
            }
            self.willChangeValue(forKey: "refshHeader")
            objc_setAssociatedObject(self, &headerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.didChangeValue(forKey: "refshHeader")
        }
        
    }

}
