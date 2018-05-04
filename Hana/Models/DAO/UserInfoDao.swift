//
//  UserInfoDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class UserInfoDao: DAO {

    // MARK: - Local

    class func findCurrentFromLocal(closure: @escaping (UserInfo?)-> Void) {
        if let guardUser = PFUser.current() {
            localFind(with: UserInfoClassName, parameters: [UserColumnName: guardUser]) { (object) in
                closure(object?.first as? UserInfo)
            }
        } else {
            closure(nil)
        }
    }
    
    // MARK: - Remote

    class func findCurrentFromRemote(closure: @escaping (UserInfo?, Bool)-> Void) {
        if let guardUser = PFUser.current() {
            remoteFind(with: UserInfoClassName, parameters: [UserColumnName: guardUser]) { (object, isSuccess) in
                closure(object?.first as? UserInfo, isSuccess)
            }
        }
    }
    
    class func findAll(closure: @escaping ([UserInfo]?, Bool) -> Void) {
        
        remoteFind(with: UserInfoClassName, parameters: nil, closure: closure)
    }
    
    class func findUserInfo(by objectId: String, closure: @escaping (UserInfo?, Bool) -> Void) {
        remoteFind(with: UserInfoClassName, parameters: [ObjectIdColumnName: objectId]) { (object, isSuccess) in
            closure(object?.first as? UserInfo, isSuccess)
        }

    }
    
    
}
