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
    
    var currentUserInfoObjectId: String?    // read from local
    
    var currentuserInfo: UserInfo? {
        let query = PFQuery(className: "UserInfo")
        query.whereKey("user", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: PFUser.current()?.objectId))
        query.fromLocalDatastore()
        do {
            let pfObject = try query.getFirstObject()
            return UserInfo.convertUserInfo(with: pfObject)
        } catch {
            return nil
        }
    }
    
    
    var currentUser: User? {
        let pfUser = PFUser.current()
        return User.convertUser(with: pfUser)
    }

}
