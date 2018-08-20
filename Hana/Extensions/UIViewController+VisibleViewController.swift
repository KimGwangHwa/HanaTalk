//
//  UIViewController+Extension.swift
//  talk
//
//  Created by 61-201405-2054 on 2018/01/19.
//

import Foundation
import UIKit

extension UIViewController {
    
    
//    let image = UIImage.colorImage(color: UIColor.red, size: CGSize(width: 10, height: 10))
//    //        navigationItem.backBarButtonItem = UIBarButtonItem(customView: UIImageView(image: image))
//    UINavigationBar.appearance().backIndicatorImage = image
//    UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
//    UINavigationBar.appearance().tintColor = UIColor.red

    func topVisibleViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topVisibleViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topVisibleViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topVisibleViewController(controller: presented)
        }
        return controller
    }
    
    func topNavigationViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UINavigationController? {
        if let navigationController = controller as? UINavigationController {
            return navigationController
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topNavigationViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topNavigationViewController(controller: presented)
        }
        return nil
    }
    
    func setNavigationBarBackIndicatorImage(_ image: UIImage) {
        
        navigationController?.navigationBar.backIndicatorImage = UIImage()
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
    }
    
    
    var navigationBarColor: UIColor {
        set{
            navigationController?.navigationBar.barTintColor = newValue
        }
        get{
            return navigationController?.navigationBar.barTintColor ?? UIColor.clear
        }
    }
    
    var navigationBarBackgroundImageIsHidden: Bool {
        set{
            if newValue {
                navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
                //navigationController?.navigationBar.shadowImage = UIImage()
            } else {
                navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
                //navigationController?.navigationBar.shadowImage = nil
            }
        }
        get{
            if let _ = navigationController?.navigationBar.backIndicatorTransitionMaskImage {
                return false
            }
            return true
        }
    }
    

}
