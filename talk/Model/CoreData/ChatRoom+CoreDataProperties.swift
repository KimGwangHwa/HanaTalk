//
//  ChatRoom+CoreDataProperties.swift
//  
//
//  Created by ひかりちゃん on 2017/09/03.
//
//

import Foundation
import CoreData


extension ChatRoom {

    @nonobjc public class func fetchChatRoomRequest() -> NSFetchRequest<ChatRoom> {
        return NSFetchRequest<ChatRoom>(entityName: "ChatRoom")
    }

    @NSManaged public var userName: String?
    @NSManaged public var unreadMessageCount: Int16
    @NSManaged public var members: [String]?
    @NSManaged public var memberCount: Int16
    @NSManaged public var createdAt: Date?
    @NSManaged public var objectId: Int16
    @NSManaged public var lastMessageId: Int16
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var coverImageUrls: [String]?

}
