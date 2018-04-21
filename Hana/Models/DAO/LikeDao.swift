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
        let predicate = NSPredicate(format: "(liked = %@ || likedBy = %@) && matched = %d", argumentArray: [currentUserInfo,currentUserInfo,true])
        
        let query = PFQuery(className: LikeClassName, predicate: predicate)
        
        query.findObjectsInBackground { (objects, error) in
            closure(objects as? [Like], error == nil ? true: false)
        }

    }
    
    
    class func find(by objectId: String, closure: @escaping (Like?, Bool) -> Void) {

        remoteFind(with: LikeClassName, parameters: [ObjectIdColumnName : objectId]) { (objects, isSuccess) in
            closure(objects?.first as? Like, true)
        }
    }
 
    class func findLiked(by userInfo: UserInfo, closure: @escaping (Like?, Bool) -> Void) {
        guard let currentUserInfo = DataManager.shared.currentuserInfo else {
            closure(nil, false)
            return
        }
        remoteFind(with: LikeClassName, parameters: [likedByColumnName : userInfo, LikedColumnName : currentUserInfo]) { (objects, isSuccess) in
            closure(objects?.first as? Like, true)
        }
    }

}
