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
        let query = PFQuery(className: LikeClassName)
        query.includeKey("liked")
        query.includeKey("disliked")
        query.includeKey("organizer")
        query.whereKey("liked", containedIn: [UserInfoDao.current()!])
        //query.whereKey("liked", containsAllObjectsIn: [UserInfoDao.current()!])
        //query.whereKey("liked", equalTo: UserInfoDao.current()!)
        query.findObjectsInBackground { (objects, error) in
            if closure != nil {
                closure!(objects as? [LikeEntity], error == nil ? true:false)
            }
        }
    }
    
    func find(by objectId: String, closure: ((Entity?, Bool) -> Void)?) {
        let query = PFQuery(className: LikedColumnName)
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
    
    func liked(with objectId: String, closure: MatchedClosure) {
        
        find(by: objectId) { (entity, isSuccess) in
            if isSuccess {
                self.matched(of: entity!, closure: closure)
            } else {
                if closure != nil {
                    closure!(false, false)
                }
            }
        }
    }
    
    private func matched(of liked: LikeEntity, closure: MatchedClosure) {
        guard let organizerObjectId = UserInfoDao.current()?.objectId else {
            if closure != nil {
                closure!(false, false)
            }
            return
        }
        find(by: organizerObjectId) { (entity, isSuccess) in
            if let entity = entity {
                entity.liked?.append(liked.organizer)
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        let isMatched = liked.liked?.contains(entity.organizer) ?? false
                        closure!(isMatched ,isSuccess)
                    }
                })
            } else {
                let entity = LikeEntity()
                entity.organizer = UserInfoEntity(withoutDataWithObjectId: organizerObjectId)
                entity.liked = [liked.organizer]
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        let isMatched = liked.liked?.contains(entity.organizer) ?? false
                        closure!(isMatched ,isSuccess)
                    }
                })
            }
        }
    }
    
    
    func disliked(with objectId: String, closure: CompletionClosure) {
        guard let organizerObjectId = UserInfoDao.current()?.objectId else {
            if closure != nil {
                closure!(nil, false)
            }
            return
        }
        find(by: organizerObjectId) { (entity, isSuccess) in
            
            if let entity = entity {
                entity.disliked?.append(UserInfoEntity(withoutDataWithObjectId: objectId))
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        closure!(entity ,isSuccess)
                    }
                })
            } else {
                let entity = LikeEntity()
                entity.organizer = UserInfoEntity(withoutDataWithObjectId: organizerObjectId)
                entity.disliked = [UserInfoEntity(withoutDataWithObjectId: objectId)]
                entity.saveInBackground(block: { (isSuccess, error) in
                    if closure != nil {
                        closure!(entity ,isSuccess)
                    }
                })
            }
        }
    }
}
