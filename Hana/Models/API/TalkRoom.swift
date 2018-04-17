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

}
