//
//  Follow+CoreDataClass.swift
//  
//
//  Created by ひかりちゃん on 2017/10/23.
//
//

import Foundation
import CoreData

@objc(Follow)
public class Follow: NSManagedObject {
    
    class func createNewRecord() -> Follow {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.Follow.rawValue, in: CoreDataManager.shared.managedObjectContext)
        let follow = Follow(entity: tweet!, insertInto: CoreDataManager.shared.managedObjectContext)
        return follow
    }

}
