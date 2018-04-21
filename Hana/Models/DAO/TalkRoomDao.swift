//
//  TalkRoomDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/15.
//

import UIKit
import Parse

class TalkRoomDao: DAO {
    // MARK: - Find
    
    class func findTalk(closure: @escaping ([TalkRoom]?, Bool)-> Void) {
        let query = PFQuery(className: TalkRoomColumnName)
        
        query.whereKey("members", containedIn: [DataManager.shared.currentuserInfo!])

        query.findObjectsInBackground { (objects, error) in
            closure(objects as? [TalkRoom], error == nil ? false: true)
        }

    }
    
    
    // MARK: - Save Update
    
    class func saveTalkRoom(with reciver: UserInfo?, lastMessage: Message?) {
        if let talkRoom = lastMessage?.talkRoom {
            talkRoom.lastMessage = lastMessage
            talkRoom.pinInBackground()
        } else {
            let room = TalkRoom()
            if let receiverUserInfo = reciver,
                let currentuserInfo = DataManager.shared.currentuserInfo {
                room.members = [receiverUserInfo, currentuserInfo]
            }
            lastMessage?.talkRoom = room
            room.lastMessage = lastMessage
            room.pinInBackground()
        }
    }


}
