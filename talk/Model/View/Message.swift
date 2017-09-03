//
//  Message.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/28.
//
//

import UIKit

enum SendReceiveType: Int {
    case Receive = 0
    case Send = 1
}
enum MessageType: Int {
    case Text = 0
    case File = 1
}
class Message: NSObject {
    
    var sendReceiveType: SendReceiveType = .Send
    
    var isRead = false
    
    // _User objectID
    var sender = ""
    
    var receiveer = ""
    
    var textMessage = ""

    var fileMessage = ""

    var messageFalg: MessageType = .Text
    
    var createAt: Date! = nil
    
    
}
