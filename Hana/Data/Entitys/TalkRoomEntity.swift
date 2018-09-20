//
//  TalkRoom.swift
//  talk
//
//  Created by ひかりちゃん on 2018/04/02.
//

import UIKit
import Parse

class TalkRoomEntity: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return TalkRoomClassName
    }

    @NSManaged var unreadCount: Int
    @NSManaged var members: [UserInfoEntity]?
    @NSManaged var lastMessage: MessageEntity?
    @NSManaged var channels: [String]?
    @NSManaged var name: String?
    @NSManaged var type: Int

//    init(members: [UserInfoEntity]?) {
//        super.init()
//        self.members = members
//        var channels = [String]()
//        for member in members ?? [] {
//            channels.append(member.objectId ?? "")
//        }
//        self.channels = channels
//    }
//    override init() {
//        super.init()
//    }

}
