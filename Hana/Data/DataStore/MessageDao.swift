//
//  MEssageDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class MessageDao: MessageRepository {
    typealias Entity = MessageEntity

    func find(by talkRoomObjectId: String, closure: (([MessageDao.Entity]?, Bool) -> Void)?) {
        let query = PFQuery(className: MessageClassName)
        query.whereKey(TalkRoomColumnName, equalTo: TalkRoomEntity(withoutDataWithObjectId: talkRoomObjectId))
        //query.fromLocalDatastore()
        query.findObjectsInBackground { (objects, error) in
            closure!(objects as? [MessageEntity], error == nil ? true: false)
        }
    }
    
    func create(with talkRoomObjectId: String, text: String, closure: ((MessageDao.Entity?, Bool) -> Void)?) {
        let entity = MessageEntity()
        entity.talkRoom = TalkRoomEntity(withoutDataWithObjectId: talkRoomObjectId)
        entity.text = text
        entity.type = 1
        entity.saveInBackground { (isSuccess, error) in
            closure!(entity, isSuccess)
        }
    }
}
