//
//  Message.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Message: NSObject {
    public var objectId: String?
    public var sender: String?
    public var receiver: String?
    public var textMessage: String?
    public var isread: Bool = false
    public var messageType: String?
    public var chatName: String?
    
    class func convertMessage(with ojbect: PFObject?) -> Message? {
        return nil;
    }
}