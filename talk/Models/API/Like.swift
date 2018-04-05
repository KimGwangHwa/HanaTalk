//
//  Like.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/18.
//

import UIKit
import Parse

class Like: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return LikeClassName
    }
    @NSManaged var userInfo: UserInfo?
    @NSManaged var likedUserInfo: UserInfo?

    class func saveLiked(userInfo: UserInfo?, completion: @escaping  (Bool) -> Void) {
        let like = Like(className: LikeClassName)
        like.userInfo = DataManager.shared.currentuserInfo
        like.likedUserInfo = userInfo
        like.saveInBackground { (isSuccess, error) in
            completion(isSuccess)
        }
    }
    
}
