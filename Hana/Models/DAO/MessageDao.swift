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

    class func isMatched(of userInfo: UserInfo?, closure: @escaping (Bool)-> Void) {
        
        if let guardUserInfo = userInfo,
            let currentUserInfo = DataManager.shared.currentuserInfo {
            localFind(with: MessageClassName, parameters: [TypeColumnName : MessageType.liked.rawValue,
                                                           ReceiverColumnName : guardUserInfo,
                                                           SenderColumnName : currentUserInfo]) { (objects) in
                                                            let isMatched = (objects?.count) ?? 0 > 0 ? true : false
                                                            closure(isMatched)
            }
        }
    }

    
    class func findBeLikedMessages(closure: @escaping ([Message]?)-> Void) {
        if let currentUserInfo = DataManager.shared.currentuserInfo {
            localFind(with: MessageClassName, parameters: [TypeColumnName : MessageType.liked.rawValue,
                                                           ReceiverColumnName : currentUserInfo])   { (objects) in
                                                            closure(objects as? [Message])
            }
        }
    }
    
    class func findLikedMessages(closure: @escaping ([Message]?)-> Void)  {
        if let currentUserInfo = DataManager.shared.currentuserInfo {
            localFind(with: MessageClassName, parameters: [TypeColumnName : MessageType.liked.rawValue,
                                                           SenderColumnName : currentUserInfo])   { (objects) in
                                                            closure(objects as? [Message])
            }
        }
    }
    
    
    // MARK: - Save Update

    
}
