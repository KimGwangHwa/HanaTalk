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
        if let currentUserInfo = DataManager.shared.currentuserInfo {
            
            let query = PFQuery(className: TalkRoomClassName)
            query.includeKey("lastMessage")
            query.whereKey("members", equalTo: currentUserInfo)
            query.findObjectsInBackground { (objects, error) in
                closure(objects as? [TalkRoom], error == nil ? true: false)
            }

        }
    }
    
    class func findTalk(by receiver: UserInfoEntity, closure: @escaping (TalkRoom?, Bool)-> Void) {
        if let currentUserInfo = DataManager.shared.currentuserInfo {
            let query = PFQuery(className: TalkRoomClassName)
            query.includeKey("lastMessage")
            query.whereKey("members", containsAllObjectsIn: [currentUserInfo, receiver])
            
            query.findObjectsInBackground { (objects, error) in
                closure(objects?.first as? TalkRoom, error == nil ? true: false)
            }
        }
    }
    
    
    
    // MARK: - Save Update
    
    class func saveTalkRoom(with reciver: UserInfoEntity?, lastMessage: Message?) {
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
