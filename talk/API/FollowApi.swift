//
//  FollowApi.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/31.
//

import UIKit
import Parse

class FollowApi: NSObject {
    typealias FollowListCompletionHandler = (Response<[Follow]>) -> Void
    
    class func findFollower(with completion: @escaping FollowListCompletionHandler) {
        findFollowing(by: "following", completion: completion)
    }
    
    class func findFollowing(with completion: @escaping FollowListCompletionHandler) {
        findFollowing(by: "userInfo", completion: completion)
    }
    
    class func findFollowing(by column: String, completion: @escaping FollowListCompletionHandler) {
        
        let followQuery = PFQuery(className: "Follow")
        guard let currentUser = DataManager.shared.currentUser,
            let currentUserObjectId = currentUser.objectId else {
                return
        }
        followQuery.includeKey(GetUserInfoType.follower.column)
        followQuery.includeKey(GetUserInfoType.following.column)
        followQuery.whereKey(column, equalTo: PFObject(withoutDataWithClassName: "UserInfo", objectId: currentUserObjectId))
        followQuery.findObjectsInBackground { (objects, error) in
            var retObjects: [Follow]?
            if let guardObjects = objects {
                retObjects = [Follow]()
                for object in guardObjects {
                    if let userInfo = Follow.convertFollow(with: object) {
                        retObjects?.append(userInfo)
                    }
                }
            }
            let response = Response<[Follow]>()
            response.data = retObjects
            response.status = error != nil ? .failure : .success
            completion(response)
        }
    }

}
