//
//  DataManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/02.
//
//

import UIKit
import Parse

class DataManager: NSObject {
    
    static let shared = DataManager()

    private let dao = UserInfoDao()
    
    private override init() {
        super.init()
        
    }
    
    var currentuserInfo: UserInfoEntity? {
        var userInfo: UserInfoEntity?
        let semaphore = DispatchSemaphore(value: 0)
        dao.findCurrentFromLocal { (entity, isSuccess) in
            userInfo = entity
            semaphore.signal()
        }
        semaphore.wait()
        return userInfo
    }
    
    
    // push ReceiveData
    var pushReceiveData: [AnyHashable : Any]!
    
    var receiveObjectId : String? {
        return pushReceiveData[kPushNotificationId] as? String
    }
    
    var receiveType: PushNotificationType? {
        return PushNotificationType(rawValue: pushReceiveData[kPushNotificationType] as! Int)
    }
    
    
}
