//
//  LoginHistory+CoreDataProperties.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/09.
//
//

import Foundation
import CoreData


extension LoginHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginHistory> {
        return NSFetchRequest<LoginHistory>(entityName: "LoginHistory")
    }

    @NSManaged public var userId: String?
    @NSManaged public var password: String?
    @NSManaged public var updateDate: NSDate?
    
    class func createNewRecord() -> LoginHistory {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.LoginHistory.rawValue, in: CoreDataManager.shared.managedObjectContext)
        let history = LoginHistory(entity: tweet!, insertInto: CoreDataManager.shared.managedObjectContext)
        return history
    }
    
    class func readLastLoginHistory() -> LoginHistory? {
        
        var lastHistory: LoginHistory? = nil
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//        let predicate = NSPredicate(format: "%K = %s", "userId", "tt")
//        fetchRequest.predicate = predicate
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            for data in fetchData {
                lastHistory = data as? LoginHistory
            }
        } catch {
        
        }
        return lastHistory
    }
}
