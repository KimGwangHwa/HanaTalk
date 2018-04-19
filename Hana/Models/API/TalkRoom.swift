//
//  TalkRoom.swift
//  talk
//
//  Created by ひかりちゃん on 2018/04/02.
//

import UIKit
import Parse

class TalkRoom: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return TalkRoomClassName
    }

    @NSManaged var unreadCount: Int
    @NSManaged var members: [UserInfo]?
    @NSManaged var lastMessage: Message?
    @NSManaged var channels: [String]?
    @NSManaged var name: String?
    @NSManaged var type: Int

    init(members: [UserInfo]?) {
        super.init()
        self.members = members
        var channels = [String]()
        for member in members ?? [] {
            channels.append(member.objectId ?? "")
        }
        self.channels = channels
    }
    override init() {
        super.init()
    }

}
