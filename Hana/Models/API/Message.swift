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
    @NSManaged var read: Bool
    @NSManaged var text: String?
    @NSManaged var imageURL: String?
    @NSManaged var sender: UserInfo?
    @NSManaged var receiver: UserInfo?
    @NSManaged var alert: String?
    @NSManaged var talkRoom: TalkRoom?
    @NSManaged var sended: Bool
    
    init(with receiver: UserInfo, text: String) {
        super.init()
        self.type = MessageType.text.rawValue
        self.text = text
        self.receiver = receiver
        self.sender = DataManager.shared.currentuserInfo
        self.alert = text
    }
    
    init(with receiver: UserInfo, imageURL: String) {
        super.init()
        self.type = MessageType.image.rawValue
        self.imageURL = imageURL
        self.receiver = receiver
        self.sender = DataManager.shared.currentuserInfo
        self.alert = "image"
    }
    
    override init() {
        super.init()
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
