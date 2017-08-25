//
//  UserRequest.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/01.
//
//

import UIKit

// stuct
class UserRequest: NSObject {
    
    var userName = ""

    var nickName = ""
    
    var password = ""
    
    var mail = ""
    
    init(userName: String, password: String) {
        super.init()
        self.userName = userName
        self.password = password
    }
    
    override init() {
        super.init()
    }
    
}
