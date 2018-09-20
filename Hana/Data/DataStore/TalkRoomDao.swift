//
//  TalkRoomDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/15.
//

import UIKit
import Parse

class TalkRoomDao: TalkRoomRepository {
    typealias Entity = TalkRoomEntity

    func find(by objectId: String, closure: ((TalkRoomEntity?, Bool) -> Void)?) {
        let query = PFQuery(className: TalkRoomClassName)
        query.includeKey("lastMessage")
        query.whereKey("objectId", equalTo: objectId)
        query.findObjectsInBackground { (objects, error) in
            closure!(objects?.first as? TalkRoomEntity, error == nil ? true: false)
        }
    }
    
    func findAll(closure: (([TalkRoomEntity]?, Bool) -> Void)?) {
        if let currentUserInfo = UserInfoDao.current() {
            let query = PFQuery(className: TalkRoomClassName)
            query.includeKey("lastMessage")
            query.whereKey("members", containedIn: [currentUserInfo])
            query.findObjectsInBackground { (objects, error) in
                closure!(objects as? [TalkRoomEntity], error == nil ? true: false)
            }
        }
    }
    
    func search(by receiver: String, closure: ((TalkRoomDao.Entity?, Bool) -> Void)?) {
        let query = PFQuery(className: TalkRoomClassName)
        query.includeKey("lastMessage")
        query.whereKey("members", containedIn: [UserInfoEntity(withoutDataWithObjectId: receiver)])
        query.findObjectsInBackground { (objects, error) in
            closure!(objects?.first as? TalkRoomEntity, error == nil ? true: false)
        }
    }
    
    func create(with partner: String, closure: ((TalkRoomDao.Entity?, Bool) -> Void)?) {
        let entity = TalkRoomEntity()
        entity.members = [UserInfoEntity(withoutDataWithObjectId: partner), UserInfoDao.current()!]
        entity.saveInBackground { (isSuccess, error) in
            closure!(entity, isSuccess)
        }
    }
    
    func save(by object: TalkRoomEntity, closure: Repository.BoolClosure) {
        object.saveInBackground { (isSuccess, error) in
            closure!(isSuccess)
        }
    }
}
