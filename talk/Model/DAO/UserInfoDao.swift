//
//  UserInfoDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/24.
//

import UIKit

class UserInfoDao: NSObject {
    
    class func findFirst() -> UserInfo? {
        let fetchRequest = UserInfo.fetchUserInfoRequest()
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData.last
        } catch {
            return nil;
        }
    }
    
    class func findBy(userId: String) -> UserInfo? {
        let fetchRequest = UserInfo.fetchUserInfoRequest()
        let predicate = NSPredicate(format: "userId = %@", userId)
        fetchRequest.predicate = predicate
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData.last
        } catch {
            return nil;
        }
    }


}
