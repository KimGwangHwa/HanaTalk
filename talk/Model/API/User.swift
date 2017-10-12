//
//  User.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/12.
//

import UIKit
import Parse

class User: PFUser {
    typealias CompletionHandler = (Bool) -> Void

    func signUpWithCompletion(completionHandler: @escaping CompletionHandler) {
        self.signUpInBackground { (isSucceeded, error) in
            completionHandler(isSucceeded)
        }
    }
    class func login(userId: String, password: String, withCompletionHandler: @escaping CompletionHandler) {
        PFUser.logInWithUsername(inBackground: userId, password: password) { (user, error) in
            if user != nil {
                let loginHistory = LoginHistory.createNewRecord()
                loginHistory.userName = user?.username
                loginHistory.password = user?.password
                //loginHistory.updateDate = user?.updatedAt ?? Date()
                loginHistory.objectId = user?.objectId
                CoreDataManager.shared.saveContext()
            }
            withCompletionHandler(user == nil ? false : true)
        }

    }
    
}
