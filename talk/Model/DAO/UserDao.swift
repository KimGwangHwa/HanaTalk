//
//  UserDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/23.
//

import UIKit

class UserDao: NSObject {
    
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
