//
//  Message+CoreDataProperties.swift
//  
//
//  Created by ひかりちゃん on 2017/09/03.
//
//

import Foundation
import CoreData

enum ResponderState: Int {
    case Receive = 0
    case Send = 1
}
enum MessageState: Int {
    case Text = 0
    case File = 1
}

extension Message {

    @nonobjc public class func fetchMessageRequest() -> NSFetchRequest<Message> {
        return NSFetchRequest<Message>(entityName: "Message")
    }

    @NSManaged public var objectId: Int16
    @NSManaged public var createdAt: Date?
    @NSManaged public var sender: String?
    @NSManaged public var receiver: String?
    @NSManaged public var textMessage: String?
    @NSManaged public var isread: Bool
    @NSManaged public var messageType: String?
    @NSManaged public var chatName: String?
    
    var responderState: ResponderState! {
        if sender == DataManager.shared.currentUserInfo?.userId {
            return .Send
        }
        if receiver == DataManager.shared.currentUserInfo?.userId {
            return .Receive
        }
        return .Receive
    }
    
    var messageState: MessageState! {
        if textMessage != nil {
            return .Text
        }
        return .File
    }
    
    
    
    

}
