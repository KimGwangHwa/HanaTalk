//
//  LoginHistory+CoreDataClass.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/09.
//
//

import Foundation
import CoreData

@objc(LoginHistory)
public class LoginHistory: NSManagedObject {

    class func createNewRecord() -> LoginHistory {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.LoginHistory.rawValue, in: CoreDataManager.shared.managedObjectContext)
        let history = LoginHistory(entity: tweet!, insertInto: CoreDataManager.shared.managedObjectContext)
        return history
    }
    
    class func readLastLoginHistory() -> LoginHistory? {
        
        var lastLoginHistory: LoginHistory? = nil
        
        let fetchRequest = LoginHistory.fetchLoginHistoryRequest()
        //        let predicate = NSPredicate(format: "%K = %s", "userId", "tt")
        //        fetchRequest.predicate = predicate
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            lastLoginHistory = fetchData.last
        } catch {
            
        }
        return lastLoginHistory
    }
    
    func removeLoginHistory() {
        let fetchRequest = LoginHistory.fetchLoginHistoryRequest()
        //        let predicate = NSPredicate(format: "%K = %s", "userId", "tt")
        //        fetchRequest.predicate = predicate
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            for data in fetchData {
                CoreDataManager.shared.managedObjectContext.delete(data)
            }
        } catch {
            
        }
    }

}

