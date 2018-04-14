//
//  UIView.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/17.
//
//

import Foundation
import UIKit

extension UIView {

    // MARK: x,y,width,height
    var x: CGFloat{
        get{
            return self.frame.origin.x
        }set{
            self.frame.origin.x = newValue
        }
    }
    
    var y: CGFloat{
        get{
            return self.frame.origin.y
        }set{
            self.frame.origin.y = newValue
        }
    }
    
    var width: CGFloat{
        get{
            return self.frame.size.width
        }set{
            self.frame.size.width = newValue
        }
    }
    
    var height: CGFloat{
        get{
            return self.frame.size.height
        }set{
            self.frame.size.height = newValue
        }
    }
    
    var size: CGSize{
        get{
            return self.frame.size
        }set{
            self.frame.size = newValue
        }
    }
    
    var origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
}
