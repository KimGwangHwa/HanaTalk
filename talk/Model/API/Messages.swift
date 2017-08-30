//
//  Messages.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/30.
//
//

import UIKit
import Parse

class Messages: PFObject {
    var sender: String? {
        didSet {
            self["sender"] = PFObject(withoutDataWithClassName: "_User", objectId: "e0o41nWPiR")
         }
    }
    var receiver = ""
    var messageFlag: Int?
    var textMessage: String? {
        didSet {
            self["textMessage"] = "xxxfe"
        }
    }
    var fileMessage: PFFile?
    var isRead: Bool = false
}
