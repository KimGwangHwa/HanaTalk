//
//  UIButton.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import Foundation
import UIKit

fileprivate var LoadingKey: Bool = false
fileprivate var IndicatorViewKey: UIActivityIndicatorView?

extension UIButton {
    
    @IBInspectable var alignVerticalSpacing: CGFloat {
        set{
            let spacing = newValue // Defualt 6
            guard let imageSize = self.imageView?.image?.size,
                let text = self.titleLabel?.text,
                let font = self.titleLabel?.font
                else { return }
            self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
            let labelString = NSString(string: text)
            let titleSize = labelString.size(withAttributes: [NSAttributedStringKey.font : font])
            self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
            self.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        }
        get {
            return CGFloat.nan
        }
        
    }
    
    @IBInspectable var imageScaleAspectFit: Bool {
        set{
            if newValue {
                self.imageView?.contentMode = .scaleAspectFit
            }
        }
        get {
            return false
        }
    }
    
    private var indicatorView: UIActivityIndicatorView? {
        get {
            guard let object = objc_getAssociatedObject(self, &IndicatorViewKey) as? UIActivityIndicatorView else {
                let view = UIActivityIndicatorView(activityIndicatorStyle: .white)
                objc_setAssociatedObject(self, &IndicatorViewKey, view, .OBJC_ASSOCIATION_RETAIN)
                return view
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &IndicatorViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    var isLoading: Bool {
        get {
            guard let object = objc_getAssociatedObject(self, &LoadingKey) as? Bool else {
                return false
            }

            return object
        }
        set {
            objc_setAssociatedObject(self, &LoadingKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            if newValue {
                self.titleLabel?.layer.opacity = 0
                self.imageView?.isHidden = true
                self.isEnabled = false
                indicatorView?.center = CGPoint(x: width/2, y: height/2)
                self.addSubview(indicatorView!)
                indicatorView?.startAnimating()
                
            } else {
                self.titleLabel?.layer.opacity = 1
                self.imageView?.isHidden = false
                self.isEnabled = true
                indicatorView?.removeFromSuperview()
            }
        }
    }
}
