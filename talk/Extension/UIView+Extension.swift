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


    func rounded(cornerRadius: CGFloat = 0.5)  {
        self.layer.cornerRadius = cornerRadius
    }
    // MARK: x,y,width,height
    var hn_x: CGFloat{
        get{
            return self.frame.origin.x
        }set{
            self.frame.origin.x = newValue
        }
    }
    
    var hn_y: CGFloat{
        get{
            return self.frame.origin.y
        }set{
            self.frame.origin.y = newValue
        }
    }
    
    var hn_width: CGFloat{
        get{
            return self.frame.size.width
        }set{
            self.frame.size.width = newValue
        }
    }
    
    var hn_height: CGFloat{
        get{
            return self.frame.size.height
        }set{
            self.frame.size.height = newValue
        }
    }
    
    var hn_size: CGSize{
        get{
            return self.frame.size
        }set{
            self.frame.size = newValue
        }
    }
    
    var hn_origin: CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin = newValue
        }
    }
}
