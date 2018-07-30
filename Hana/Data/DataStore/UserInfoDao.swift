//
//  UserInfoDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class UserInfoDao: UserInfoRepository {

    func signin(username: String, password: String, closure: BoolClosure) {
        PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
            if error == nil {
                if closure != nil {
                    closure!(true)
                }
            }
        }
    }
    
    func existence(username: String, closure: BoolClosure) {
        let query = PFQuery(className: UserClassName)
        query.whereKey("username", notEqualTo: username)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if closure != nil {
                    closure!(true)
                }
            }
        }
    }
    
    func signup(username: String, password: String, closure: BoolClosure) {
        
        let user = PFUser()
        user.username = username
        user.password = password
        
        user.signUpInBackground { (isSuccess, error) in
            if error == nil {
                if closure != nil {
                    let userInfo = UserInfoEntity()
                    userInfo.nickname = username
                    userInfo.user = PFUser.current()
                    userInfo.saveInBackground(block: { (isSuccess, error) in
                        closure!(isSuccess)
                    })
                }
            }
        }
    }
    
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
        query.whereKey(ObjectIdColumnName, equalTo: objectId)
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
