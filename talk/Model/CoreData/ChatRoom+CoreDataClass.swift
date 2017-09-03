//
//  ChatRoom+CoreDataClass.swift
//  
//
//  Created by ひかりちゃん on 2017/09/03.
//
//

import Foundation
import CoreData

@objc(ChatRoom)
public class ChatRoom: NSManagedObject {

    class func createNewRecord() -> ChatRoom {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.ChatRoom.rawValue, in: CoreDataManager.shared.managedObjectContext)
        let chatRoom = ChatRoom(entity: tweet!, insertInto: CoreDataManager.shared.managedObjectContext)
        chatRoom.objectId = chatRoom.getMaxID()
        chatRoom.createdAt = NSDate()
        return chatRoom
    }
    
    class func find(chatName: String) -> ChatRoom? {
        
        let fetchRequest = ChatRoom.fetchChatRoomRequest()
        let predicate = NSPredicate(format: "name = %@", chatName)
        fetchRequest.predicate = predicate
        
        do {
            
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            if !fetchData.isEmpty {
                return fetchData.first
            }
            
        } catch {
            
        }
        return nil
    }
    
    class func isExistence(chatName: String) -> Bool {
        
        let fetchRequest = ChatRoom.fetchChatRoomRequest()
        let predicate = NSPredicate(format: "%K = %s", "name", chatName)
        fetchRequest.predicate = predicate
        
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            if fetchData.isEmpty {
                return false
            } else {
                return true
            }
            
        } catch {
            
        }
        return false
    }
    
    class func readAllData() -> [ChatRoom] {
        let fetchRequest = ChatRoom.fetchChatRoomRequest()
        
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            
            return fetchData
            
        } catch {
            
        }
        return []

    }
    
    private func getMaxID() -> Int16 {
        let fetchRequest = ChatRoom.fetchChatRoomRequest()
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
    
}
