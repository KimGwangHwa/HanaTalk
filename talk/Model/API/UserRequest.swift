//
//  UserRequest.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/01.
//
//

import UIKit

class UserRequest: NSObject {
    
    var id = ""

    var nickName = ""
    
    var password = ""
    
    var mail = ""
    
    init(id: String, password: String) {
        super.init()
        self.id = id
        self.password = password
    }
    
    override init() {
        super.init()
    }
    
}
