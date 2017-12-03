//
//  MessageDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/24.
//

import UIKit

class MessageDao: NSObject {
    /*
    class func find(chatName: String) -> [Message]? {
        
        let fetchRequest = Message.fetchMessageRequest()
        let predicate = NSPredicate(format: "chatName = %@", chatName)
        fetchRequest.predicate = predicate
        
        do {
            let fetchData = try CoreDataHelper.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData
        } catch {
            
        }
        return nil
    }
    class func find(objectId: String?) -> Message? {
        
        if let guardObjectId = objectId {
            let fetchRequest = Message.fetchMessageRequest()
            let predicate = NSPredicate(format: "objectId = %@", guardObjectId)
            fetchRequest.predicate = predicate
            
            do {
                let fetchData = try CoreDataHelper.shared.managedObjectContext.fetch(fetchRequest)
                return fetchData.first
            } catch {
                
            }
        }
        return nil
    }
    
    class func updateReadingStatus(with chatName: String) {
        if let messages = find(chatName: chatName) {
            for message in messages {
                message.isread = true
            }
        }
        
        if let chatRoom = ChatRoomDao.find(chatName: chatName) {
            chatRoom.unreadMessageCount = 0
        }
        
        CoreDataHelper.shared.saveContext()
    }
 */
}
