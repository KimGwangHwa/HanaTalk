//
//  Posts.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Posts: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return "Posts"
    }

    @NSManaged var poster: UserInfo?
    @NSManaged var imageFiles: [PFFile]?
    @NSManaged var imageUrls: [String]?

    @NSManaged var messages: [Message]?
    @NSManaged var likeds: [UserInfo]?
    @NSManaged var contents: String?
    
    class func findPosts(by userInfo: UserInfo? = nil, completion: @escaping ([Posts]?, Bool) -> Void) {
        let postsQuery = PFQuery(className: "Posts")
        if let guardUserInfo = userInfo {
            postsQuery.whereKey("poster", equalTo: guardUserInfo)
        }
        postsQuery.includeKeys(["poster", "likeds", "messages"])
        postsQuery.findObjectsInBackground { (pfobjects, error) in
            
            if let guardObjects = pfobjects {
                var retObjects = [Posts]()
                for object in guardObjects {
                    if let postsObject = object as? Posts {
                        retObjects.append(postsObject)
                    }
                }
                completion(retObjects, true)
            } else {
                completion(nil, false)
            }
        }
    }
    
    class func countPosts(by userInfo: UserInfo?, completion: @escaping (Int, Bool) -> Void) {
        let postsQuery = PFQuery(className: "Posts")
        if let guardUserInfo = userInfo {
            postsQuery.whereKey("poster", equalTo: guardUserInfo)
        }
        postsQuery.countObjectsInBackground { (count, error) in
            if error == nil {
                completion(Int(count), true)
            }
        }
    }
    
    
    
}
