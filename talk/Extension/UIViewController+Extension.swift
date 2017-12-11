//
//  UIViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/27.
//
//

import Foundation
import UIKit

extension UIViewController {
    
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

}
