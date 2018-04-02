//
//  Message.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

// MARK: - Message Type
enum MessageType: Int {
    case liked = 0
    case image
    case text
}

class Message: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return MessageClassName
    }
    @NSManaged var type: Int
    @NSManaged var isAlreadyRead: Bool
    @NSManaged var text: String?
    @NSManaged var imageURL: String?
    @NSManaged var sender: UserInfo?
    @NSManaged var receiver: UserInfo?
    @NSManaged var title: String?


    // MARK: - Dao
    class func newMessage(with receiver: UserInfo?, text: String?) -> Message {
        let message = Message()
        message.type = MessageType.text.rawValue
        message.isAlreadyRead = false
        message.text = text
        message.receiver = receiver
        message.sender = DataManager.shared.currentuserInfo
        return message
    }
    
    class func newMessage(with receiver: UserInfo?, imageURL: String?) -> Message {
        let message = Message()
        message.type = MessageType.image.rawValue
        message.isAlreadyRead = false
        message.imageURL = imageURL
        message.receiver = receiver
        message.sender = DataManager.shared.currentuserInfo
        return message
    }
    
    class func newLikedMessage(with receiver: UserInfo?) -> Message {
        let message = Message()
        message.type = MessageType.liked.rawValue
        message.isAlreadyRead = false
        message.receiver = receiver
        message.sender = DataManager.shared.currentuserInfo
        message.title = "liked from " + (receiver?.nickname)!
        return message
    }
    
    class func newReceiveRemoteNotification(_ userInfo: [AnyHashable : Any]) -> Message {
        let message = Message()
        message.type = userInfo[kPushNotificationType] as! Int
        message.isAlreadyRead = false
        message.sender = UserInfo(withoutDataWithObjectId: userInfo[kPushNotificationFrom] as? String)
        message.receiver = DataManager.shared.currentuserInfo
        return message
    }

    class func isMatched(of userInfo: UserInfo?) -> Bool {
        let query = PFQuery(className: MessageClassName)
        if let guardUserInfo = userInfo,
            let currentUserInfo = DataManager.shared.currentuserInfo {
            query.whereKey(TypeColumnName, equalTo: MessageType.liked.rawValue)
            query.whereKey(ReceiverColumnName, equalTo: guardUserInfo)
            query.whereKey(SenderColumnName, equalTo: currentUserInfo)
        }
        query.fromLocalDatastore()
        return query.countObjects(nil) > 0 ? true : false
    }
    
}
