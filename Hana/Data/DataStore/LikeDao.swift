//
//  LikeDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/17.
//

import UIKit
import Parse

class LikeDao: LikeRepository {
    typealias Entity = LikeEntity
    
    func findAll(closure: (([Entity]?, Bool) -> Void)?) {
        let query = PFQuery(className: EventClassName)
        query.includeKey("liked")
        query.includeKey("disliked")
        query.includeKey("organizer")
        query.whereKey("liked", equalTo: DataManager.shared.currentuserInfo!)
        query.findObjectsInBackground { (objects, error) in
            if closure != nil {
                closure!(objects as? [LikeEntity], error == nil ? true:false)
            }
        }
    }
    
    func find(by objectId: String, closure: ((Entity?, Bool) -> Void)?) {
        let query = PFQuery(className: EventClassName)
        query.includeKey("liked")
        query.includeKey("disliked")
        query.includeKey("organizer")
        query.whereKey("organizer", equalTo: Entity(withoutDataWithObjectId: objectId))
        query.findObjectsInBackground { (objects, error) in
            if closure != nil {
                closure!(objects?.first as? LikeEntity, error == nil ? true:false)
            }
        }
    }
    
    func save(by object: LikeEntity, closure: BoolClosure) {
        object.saveInBackground { (isSuccess, error) in
            if closure != nil {
                closure!(isSuccess)
            }
        }
    }
    
    func save(by organizer: String, likedAt objectId: String, closure: BoolClosure) {
        
        find(by: organizer) { (entity, isSuccess) in
            if let entity = entity {
                entity.liked?.append(UserInfoEntity(withoutDataWithObjectId: objectId))
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        closure!(isSuccess)
                    }
                })
            } else {
                let entity = LikeEntity()
                entity.organizer = UserInfoEntity(withoutDataWithObjectId: organizer)
                entity.liked = [UserInfoEntity(withoutDataWithObjectId: objectId)]
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        closure!(isSuccess)
                    }
                })
            }
        }
    }
    
    func save(by organizer: String, dislikedAt objectId: String, closure: BoolClosure) {
        
        find(by: organizer) { (entity, isSuccess) in
            
            if let entity = entity {
                entity.disliked?.append(UserInfoEntity(withoutDataWithObjectId: objectId))
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        closure!(isSuccess)
                    }
                })
            } else {
                let entity = LikeEntity()
                entity.organizer = UserInfoEntity(withoutDataWithObjectId: organizer)
                entity.disliked = [UserInfoEntity(withoutDataWithObjectId: objectId)]
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        closure!(isSuccess)
                    }
                })
            }

        }

    }
    
    /*
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
     
     */
    

}
