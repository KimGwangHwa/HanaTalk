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
    
    class func findTalk(closure: @escaping ([TalkRoomEntity]?, Bool)-> Void) {
        if let currentUserInfo = UserInfoDao.current() {
            
            let query = PFQuery(className: TalkRoomClassName)
            query.includeKey("lastMessage")
            query.whereKey("members", equalTo: currentUserInfo)
            query.findObjectsInBackground { (objects, error) in
                closure(objects as? [TalkRoomEntity], error == nil ? true: false)
            }

        }
    }
    
    class func findTalk(by receiver: UserInfoEntity, closure: @escaping (TalkRoomEntity?, Bool)-> Void) {
        if let currentUserInfo = UserInfoDao.current() {
            let query = PFQuery(className: TalkRoomClassName)
            query.includeKey("lastMessage")
            query.whereKey("members", containsAllObjectsIn: [currentUserInfo, receiver])
            
            query.findObjectsInBackground { (objects, error) in
                closure(objects?.first as? TalkRoomEntity, error == nil ? true: false)
            }
        }
    }
    
    
    
    // MARK: - Save Update
    
    class func saveTalkRoom(with reciver: UserInfoEntity?, lastMessage: MessageEntity?) {
        if let talkRoom = lastMessage?.talkRoom {
            talkRoom.lastMessage = lastMessage
            talkRoom.pinInBackground()
        } else {
            let room = TalkRoomEntity()
            if let receiverUserInfo = reciver,
                let currentuserInfo = UserInfoDao.current() {
                room.members = [receiverUserInfo, currentuserInfo]
            }
            lastMessage?.talkRoom = room
            room.lastMessage = lastMessage
            room.pinInBackground()
        }
    }


}
