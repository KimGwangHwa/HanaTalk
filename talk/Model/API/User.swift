//
//  User.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class User: NSObject {
    public var objectId: String?
    public var userName: String?
    public var password: String?
    
    init(withObjectId: String?) {
        super.init()
        self.objectId = withObjectId
    }
    override init() {
        super.init()
    }
    
    class func convertUser(with ojbect: PFObject?) -> User? {

        if let guardObject = ojbect {
            let newUser = User()
            newUser.objectId = guardObject.objectId ?? ""
            newUser.userName = guardObject["userName"] as? String
            return newUser
        }
        return nil
    }

}
