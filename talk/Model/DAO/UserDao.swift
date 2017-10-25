//
//  UserDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/23.
//

import UIKit
import Parse

class UserDao: NSObject {
    
    private let pfObject: PFUser = PFUser();
    
    func signUp(user: User, completion: @escaping StatusCompletionHandler) {
        pfObject.username = user.userName
        pfObject.password = user.password
        
        pfObject.signUpInBackground { (isSucceeded, error) in
            completion(isSucceeded == true ? .Success: .Failure)
        }
    }
    
    func login(user: User, completion: @escaping StatusCompletionHandler) {
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

    func findFirst() -> User? {
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
