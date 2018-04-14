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

    @NSManaged var unreadMessageCount: Int
    @NSManaged var members: [UserInfo]?
    @NSManaged var lastMessage: Message?
    
    class func saveTalkRoom(with userInfo: UserInfo?, message: Message?) {
        if let talkRoom = message?.talkRoom {
            talkRoom.lastMessage = message
            talkRoom.pinInBackground()
        } else {
            let room = TalkRoom()
            if let receiverUserInfo = userInfo,
                let currentuserInfo = DataManager.shared.currentuserInfo {
                room.members = [receiverUserInfo, currentuserInfo]
            }
            message?.talkRoom = room
            room.lastMessage = message
            room.pinInBackground()
        }
    }
    
}
