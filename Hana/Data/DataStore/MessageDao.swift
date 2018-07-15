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
 
    class func findMessages(with talkRoom: TalkRoom, closure: @escaping ([Message]?)-> Void) {
        localFind(with: MessageClassName, parameters: [TalkRoomColumnName : talkRoom], closure: closure)
    }
    
    class func find(by talkRoom: TalkRoom, closure: @escaping ([Message]?, Bool)-> Void) {
        remoteFind(with: MessageClassName, parameters: [TalkRoomColumnName : talkRoom], closure: closure)
    }
    
    class func find(by objectId: String, completion: @escaping (Message?, Bool) -> Void) {
        
        remoteFind(with: MessageClassName, parameters: [ObjectIdColumnName : objectId]) { (objects, isSuccess) in
            completion(objects?.first as? Message, true)
        }
    }

    
    
    // MARK: - Save Update

    
}
