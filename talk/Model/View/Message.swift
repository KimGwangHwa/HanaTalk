//
//  Message.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/28.
//
//

import UIKit

class Message: NSObject {
    enum SendReceiveType: Int {
        case Receive = 0
        case Send = 1
    }
    
    var sendReceiveType: SendReceiveType = .Send
    
    var textMessage = ""
    
    var userName = ""
    
    var createDate = Date()
    
    var senderUserName = ""
    
}
