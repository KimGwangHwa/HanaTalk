//
//  DataManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/02.
//
//

import UIKit

class DataManager: NSObject {
    
    static let shared = DataManager()

    private override init() {
        super.init()
        
    }
    
    var currentUser: User? = UserDao().findFirst()
    
    var currentUserObjectId: String = (LoginHistory.readLastLoginHistory()?.objectId) ?? ""
    
    func currentUserInfo() -> UserInfo? {
        
        if let guardCurrentUser = currentUser {
            return UserInfoDao().findBy(userId: guardCurrentUser.objectId)
        }
        return nil;
    }
    
    var chatRooms: [ChatRoom] {
        return ChatRoom.readAllData()
    }
    
    

}
