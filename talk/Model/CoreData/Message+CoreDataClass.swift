//
//  Message+CoreDataClass.swift
//  
//
//  Created by ひかりちゃん on 2017/09/03.
//
//

import Foundation
import CoreData

@objc(Message)
public class Message: NSManagedObject {
    
    class func createNewRecord() -> Message {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.Message.rawValue, in: CoreDataHelper.shared.managedObjectContext)
        let message = Message(entity: tweet!, insertInto: CoreDataHelper.shared.managedObjectContext)
        message.createdAt = Date()
        return message
    }        
}
