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
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.Message.rawValue, in: CoreDataManager.shared.managedObjectContext)
        let message = Message(entity: tweet!, insertInto: CoreDataManager.shared.managedObjectContext)
        message.objectId = message.getMaxID()
        message.createdAt = Date()
        return message
    }
    
    func getMaxID() -> Int16 {
        let fetchRequest = Message.fetchMessageRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "objectId", ascending: false)]
        
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            if fetchData.isEmpty {
                return 1
            } else {
                
                if let firstData = fetchData.first {
                    return firstData.objectId + 1
                }
            }
        } catch {
            
        }
        return 0
    }
    class func find(chatName: String) -> [Message]? {
        
        let fetchRequest = Message.fetchMessageRequest()
        let predicate = NSPredicate(format: "chatName = %@", chatName)
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData
        } catch {
            
        }
        return nil
    }
    class func find(objectId: Int16) -> Message? {
        
        let fetchRequest = Message.fetchMessageRequest()
        let predicate = NSPredicate(format: "objectId = %d", objectId)
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData.first
        } catch {
            
        }
        return nil
    }
    
    class func updateReadingStatus(with chatName: String) {
        if let messages = find(chatName: chatName) {
            for message in messages {
                message.isread = true
            }
        }
        
        if let chatRoom = ChatRoom.find(chatName: chatName) {
            chatRoom.unreadMessageCount = 0
        }
        
        CoreDataManager.shared.saveContext()

    }
    
}
