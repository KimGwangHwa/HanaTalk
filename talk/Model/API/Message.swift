//
//  Message.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return UserInfoClassName
    }

    @NSManaged var type: String?

}
