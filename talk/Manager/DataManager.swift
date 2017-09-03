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
    var currentUser: User? = nil
    
    var friends: [User] = [User]()
    
    var chatRooms: [ChatRoom] {
        return ChatRoom.readAllData()
    }
    
    

}
