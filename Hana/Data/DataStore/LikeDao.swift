//
//  LikeDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/17.
//

import UIKit
import Parse

class LikeDao: DAO {

    
    class func find(closure: @escaping ([Like]?, Bool) -> Void) {
        guard let currentUserInfo = DataManager.shared.currentuserInfo else {
            closure(nil, false)
            return
        }
        let predicate = NSPredicate(format: "(liked = %@ || likedBy = %@) && likedBy != %@ ", argumentArray: [currentUserInfo, currentUserInfo, currentUserInfo])
        let query = PFQuery(className: LikeClassName, predicate: predicate)
        query.order(byAscending: "matched")
        query.order(byAscending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            closure(objects as? [Like], error == nil ? true: false)
        }

    }
    
    
    class func find(by objectId: String, closure: @escaping (Like?, Bool) -> Void) {

        remoteFind(with: LikeClassName, parameters: [ObjectIdColumnName : objectId]) { (objects, isSuccess) in
            closure(objects?.first as? Like, true)
        }
    }
 
    class func findLiked(by userInfo: UserInfoEntity, closure: @escaping (Like?, Bool) -> Void) {
        
        
        guard let currentUserInfo = DataManager.shared.currentuserInfo else {
            closure(nil, false)
            return
        }
        remoteFind(with: LikeClassName, parameters: [likedByColumnName : userInfo, LikedColumnName : currentUserInfo]) { (objects, isSuccess) in
            closure(objects?.first as? Like, true)
        }
    }

}
