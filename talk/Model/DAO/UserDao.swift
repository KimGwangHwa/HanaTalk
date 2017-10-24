//
//  UserDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/23.
//

import UIKit
import Parse

class UserDao: PFObject {
    
    let pfObject: PFObject = PFObject(className: "_User");
    
    
//    class func signUp(with userId: String, password: String, completion: @escaping StatusCompletionHandler) {
//        
//        self.signUpInBackground { (isSucceeded, error) in
//            completion(isSucceeded == true ? .Success: .Failure)
//        }
//    }
//    
//    class func login(with userId: String, password: String, completion: @escaping StatusCompletionHandler) {
//        PFUser.logInWithUsername(inBackground: userId, password: password) { (user, error) in
//            if user != nil {
//                let loginHistory = LoginHistory.createNewRecord()
//                loginHistory.userName = user?.username
//                loginHistory.password = user?.password
//                //loginHistory.updateDate = user?.updatedAt ?? Date()
//                loginHistory.objectId = user?.objectId
//                CoreDataManager.shared.saveContext()
//            }
//            completion(user != nil ? .Success: .Failure)
//        }
//    }

}
