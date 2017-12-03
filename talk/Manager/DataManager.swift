//
//  DataManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/02.
//
//

import UIKit
import Parse

class DataManager: NSObject {
    
    static let shared = DataManager()

    private override init() {
        super.init()
        
    }
    
    var currentUser: User? {
        let pfUser = PFUser.current()
        return User.convertUser(with: pfUser)
    }

}
