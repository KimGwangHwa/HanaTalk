//
//  UserInfoDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class UserInfoDao: DAO {

    class func findCurrent(closure: @escaping (UserInfo?)-> Void) {
        if let guardUser = PFUser.current() {
            localFind(with: UserInfoClassName, parameters: [UserColumnName: guardUser]) { (object) in
                closure(object?.first as? UserInfo)
            }
        }
    }

    
}
