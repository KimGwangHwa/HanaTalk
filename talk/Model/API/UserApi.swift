//
//  UserApi.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/31.
//

import UIKit
import Parse

class UserApi: NSObject {
    class func signUp(user: User, completion: @escaping StatusCompletionHandler) {
        let pfObject: PFUser = PFUser()
        pfObject.username = user.userName
        pfObject.password = user.password
        
        pfObject.signUpInBackground { (isSucceeded, error) in
            user.objectId = pfObject.objectId ?? ""
            user.createAt = pfObject.createdAt ?? Date()
            user.updateAt = pfObject.updatedAt ?? Date()
            CoreDataHelper.shared.saveContext()
            completion(isSucceeded == true ? .Success: .Failure)
        }
    }
    
    class func login(user: User, completion: @escaping StatusCompletionHandler) {
        PFUser.logInWithUsername(inBackground: user.userName, password: user.password) { (pfUser, error) in
            if let guradUser = pfUser {
                user.objectId = guradUser.objectId ?? ""
                user.createAt = guradUser.createdAt ?? Date()
                user.updateAt = guradUser.updatedAt ?? Date()
                CoreDataHelper.shared.saveContext()
            }
            completion(pfUser != nil ? .Success: .Failure)
        }
    }
}
