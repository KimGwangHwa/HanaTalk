//
//  NavigationBar.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/03.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    func backIndicatorImage(_ image: UIImage) {
        backIndicatorImage = image
        backIndicatorTransitionMaskImage = image
    }
}
