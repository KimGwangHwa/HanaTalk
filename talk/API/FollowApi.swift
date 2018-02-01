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
    
    class func findFollower(by userObjectId: String?, completion: @escaping FollowListCompletionHandler) {
        findFollow(by: "following", userObjectId: userObjectId, completion: completion)
    }
    
    class func findFollowing(by userObjectId: String?, completion: @escaping FollowListCompletionHandler) {
        findFollow(by: "userInfo", userObjectId: userObjectId, completion: completion)
    }
    
    class func findFollow(by column: String, userObjectId: String?, completion: @escaping FollowListCompletionHandler) {
        
        let followQuery = PFQuery(className: "Follow")

        followQuery.includeKey("following")
        followQuery.includeKey("userInfo")
        followQuery.whereKey(column, equalTo: PFObject(withoutDataWithClassName: "UserInfo", objectId: userObjectId))
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
