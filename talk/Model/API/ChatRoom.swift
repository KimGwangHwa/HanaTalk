//
//  ChatRoom.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit

class ChatRoom: NSObject {
    public var userName: String?
    public var unreadMessageCount: Int16
    public var members: [String]?
    public var memberCount: Int16
    public var createdAt: Date?
    public var objectId: String
    public var lastMessageId: String?
    public var name: String?
    public var url: String?
    public var coverImageUrls: [String]?
}
