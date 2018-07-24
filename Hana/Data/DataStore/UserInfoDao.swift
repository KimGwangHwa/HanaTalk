//
//  UserInfoDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class UserInfoDao: UserInfoRepository {
    
    typealias Entity = UserInfoEntity

    func findCurrent(closure: CompletionClosure) {
        find(closure: closure)
    }
    
    private func find(by isLocal: Bool = false, closure: CompletionClosure) {
        if let guardUser = PFUser.current() {
            let query = PFQuery(className: UserInfoClassName)
            query.includeKey("todayWantCategory")
            query.whereKey(UserColumnName, equalTo: guardUser)
            if isLocal == true {
                query.fromLocalDatastore()
            }
            query.findObjectsInBackground { (objects, error) in
                guard let entity = objects?.first as? UserInfoEntity else {
                    if closure != nil {
                        closure!(nil, false)
                    }
                    return
                }
                entity.pinInBackground()
                if closure != nil {
                    closure!(entity, error == nil ? true:false)
                }
            }
        } else {
            if closure != nil {
                closure!(nil, false)
            }
        }
    }
    
    func findCurrentFromLocal(closure: ((UserInfoEntity?, Bool) -> Void)?) {
       find(by: true, closure: closure)
    }
    
    func findAll(closure: MultipleCompletionClosure) {
        let query = PFQuery(className: UserInfoClassName)
        query.whereKey(UserColumnName, notEqualTo: PFUser.current()!)
        query.findObjectsInBackground { (objects, error) in
            if closure != nil {
                closure!(objects as? [UserInfoEntity], error == nil ? true: false)
            }
        }
    }
    
    func find(by objectId: String, closure: CompletionClosure) {
        let query = PFQuery(className: UserInfoClassName)
        query.whereKey(ObjectIdColumnName, notEqualTo: objectId)
        query.findObjectsInBackground { (objects, error) in
            if closure != nil {
                closure!(objects?.first as? UserInfoEntity, error == nil ? true: false)
            }
        }
    }
    
    func save(by object: UserInfoEntity, closure: BoolClosure) {
        object.saveInBackground { (isSuccess, error) in
            object.pinInBackground()
            if closure != nil {
                closure!(isSuccess)
            }
        }
    }
    
}
