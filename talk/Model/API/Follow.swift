//
//  Follow.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Follow: NSObject {
    public var following: UserInfo?
    public var objectId: String?
    public var userInfo: UserInfo?
    
    class func convertFollow(with ojbect: PFObject?) -> Follow? {
        if let guardObject = ojbect {
            let retObject: Follow = Follow()
            retObject.objectId = guardObject.objectId
            if let userInfo = guardObject["userInfo"] as? PFObject {
                retObject.userInfo = UserInfo.convertUserInfo(with: userInfo)
            }
            if let following = guardObject["following"] as? PFObject {
                retObject.following = UserInfo.convertUserInfo(with: following)
            }
            return retObject
        }
        return nil

    }
}
