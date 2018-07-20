//
//  UIAlertController.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/20.
//

import Foundation
import UIKit

extension UIAlertController {
    
    typealias Handler = ()->Void
    
    class func show(in viewController: UIViewController,
                    _ cameraHandler: @escaping Handler,
                    albumHandler: @escaping Handler) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            cameraHandler()
        }))
        alert.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
            albumHandler()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
