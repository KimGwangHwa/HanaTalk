//
//  UserDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/23.
//

import UIKit
import Parse

class UserDao: NSObject {
    
    class func signUp(user: User, completion: @escaping StatusCompletionHandler) {
        let pfObject: PFUser = PFUser()
        pfObject.username = user.userName
        pfObject.password = user.password
        
        pfObject.signUpInBackground { (isSucceeded, error) in
            user.objectId = pfObject.objectId ?? ""
            user.createAt = pfObject.createdAt ?? Date()
            user.updateAt = pfObject.updatedAt ?? Date()
            CoreDataManager.shared.saveContext()
            completion(isSucceeded == true ? .Success: .Failure)
        }
    }
    
    class func login(user: User, completion: @escaping StatusCompletionHandler) {
        PFUser.logInWithUsername(inBackground: user.userName, password: user.password) { (pfUser, error) in
            if let guradUser = pfUser {
                user.objectId = guradUser.objectId ?? ""
                user.createAt = guradUser.createdAt ?? Date()
                user.updateAt = guradUser.updatedAt ?? Date()
                CoreDataManager.shared.saveContext()
            }
            completion(pfUser != nil ? .Success: .Failure)
        }
    }

    class func findFirst() -> User? {
        var user: User? = nil;
        let fetchRequest = User.fetchUserRequest()
        //        let predicate = NSPredicate(format: "%K = %s", "userId", "tt")
        //        fetchRequest.predicate = predicate
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            user = fetchData.last
        } catch {
            return nil;
        }
        return user
    }
    
}
