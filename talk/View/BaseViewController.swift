//
//  BaseViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/07.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage.colorImage(color: UIColor.red, size: CGSize(width: 10, height: 10))
//        navigationItem.backBarButtonItem = UIBarButtonItem(customView: UIImageView(image: image))
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        UINavigationBar.appearance().tintColor = UIColor.red

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
