//
//  UserDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/23.
//

import UIKit
import Parse

class UserDao: PFObject {
    
    private let pfObject: PFUser = PFUser();
    
    func signUp(user: User, completion: @escaping StatusCompletionHandler) {
        pfObject.username = user.userName
        pfObject.password = user.password
        pfObject.signUpInBackground { (isSucceeded, error) in
            completion(isSucceeded == true ? .Success: .Failure)
        }
    }
    
    func login(user: User, completion: @escaping StatusCompletionHandler) {
        PFUser.logInWithUsername(inBackground: user.userName ?? "", password: user.password ?? "") { (user, error) in
            if user != nil {
                CoreDataManager.shared.saveContext()
            }
            completion(user != nil ? .Success: .Failure)
        }
    }

}
