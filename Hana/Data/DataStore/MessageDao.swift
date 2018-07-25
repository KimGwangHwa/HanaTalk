//
//  MEssageDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class MessageDao: DAO {

    // MARK: - Find
 
    class func findMessages(with talkRoom: TalkRoomEntity, closure: @escaping ([MessageEntity]?)-> Void) {
        localFind(with: MessageClassName, parameters: [TalkRoomColumnName : talkRoom], closure: closure)
    }
    
    class func find(by talkRoom: TalkRoomEntity, closure: @escaping ([MessageEntity]?, Bool)-> Void) {
        remoteFind(with: MessageClassName, parameters: [TalkRoomColumnName : talkRoom], closure: closure)
    }
    
    class func find(by objectId: String, completion: @escaping (MessageEntity?, Bool) -> Void) {
        
        remoteFind(with: MessageClassName, parameters: [ObjectIdColumnName : objectId]) { (objects, isSuccess) in
            completion(objects?.first as? MessageEntity, true)
        }
    }

    
    
    // MARK: - Save Update

    
}
