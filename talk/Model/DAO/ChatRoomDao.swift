//
//  ChatRoomDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/24.
//

import UIKit

class ChatRoomDao: NSObject {
    
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
    
    class func readAllData() -> [ChatRoom]? {
        let fetchRequest = ChatRoom.fetchChatRoomRequest()
        
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            
            return fetchData
            
        } catch {
            
        }
        return nil
        
    }
}
