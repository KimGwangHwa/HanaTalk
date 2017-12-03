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
            completion(isSucceeded == true ? .success: .failure)
        }
    }
    
    class func login(user: User, completion: @escaping StatusCompletionHandler) {
        
        guard let userName = user.userName,
            let password = user.password else {
            completion(.failure)
            return;
        }
        
        PFUser.logInWithUsername(inBackground: userName, password: password) { (pfUser, error) in
            if let guradUser = pfUser {
                user.objectId = guradUser.objectId ?? ""
            }
            completion(pfUser != nil ? .success: .failure)
        }
    }
}
