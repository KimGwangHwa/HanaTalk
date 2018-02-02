//
//  Follow.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Follow: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Follow"
    }
    
    @NSManaged var followed: UserInfo?
    @NSManaged var userInfo: UserInfo?
    
    
    class func findFollower(by userInfoObjectId: String?, completion: @escaping ([Follow]?, Bool) -> Void) {
        findFollow(by: "following", userInfoObjectId: userInfoObjectId, completion: completion)
    }

    class func findFollowing(by userInfoObjectId: String?, completion: @escaping ([Follow]?, Bool) -> Void) {
        findFollow(by: "userInfo", userInfoObjectId: userInfoObjectId, completion: completion)
    }
    
    class func findFollow(by column: String, userInfoObjectId: String?, completion: @escaping ([Follow]?, Bool) -> Void) {
        
        let followQuery = PFQuery(className: "Follow")
        
        followQuery.includeKey("following")
        followQuery.includeKey("userInfo")
        followQuery.whereKey(column, equalTo: PFObject(withoutDataWithClassName: "UserInfo", objectId: userInfoObjectId))
        followQuery.findObjectsInBackground { (objects, error) in
            var retObjects: [Follow]?
            if let guardObjects = objects {
                retObjects = [Follow]()
                for object in guardObjects {
                    if let userInfo = object as? Follow {
                        retObjects?.append(userInfo)
                    }
                }
            }
            completion(retObjects, true)
        }
    }
    
    
    class func countFollower(by userInfoObjectId: String?, completion: @escaping (Int, Bool) -> Void) {
        countFollow(by: "following", userInfoObjectId: userInfoObjectId, completion: completion)
    }
    
    class func countFollowing(by userInfoObjectId: String?, completion: @escaping (Int, Bool) -> Void) {
        countFollow(by: "userInfo", userInfoObjectId: userInfoObjectId, completion: completion)
    }
    class func countFollow(by column: String, userInfoObjectId: String?, completion: @escaping (Int, Bool) -> Void) {
        
        let followQuery = PFQuery(className: "Follow")
        followQuery.whereKey(column, equalTo: PFObject(withoutDataWithClassName: "UserInfo", objectId: userInfoObjectId))
        followQuery.countObjectsInBackground { (count, error) in
            if error == nil {
                completion(Int(count), true)
            }
        }
    }

}
