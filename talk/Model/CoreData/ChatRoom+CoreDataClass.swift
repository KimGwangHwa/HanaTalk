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
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.ChatRoom.rawValue, in: CoreDataHelper.shared.managedObjectContext)
        let chatRoom = ChatRoom(entity: tweet!, insertInto: CoreDataHelper.shared.managedObjectContext)
        chatRoom.createdAt = Date()
        return chatRoom
    }
    
}
