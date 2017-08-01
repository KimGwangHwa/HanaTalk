//
//  RemoteAPIManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/01.
//
//

import UIKit
import Parse

class RemoteAPIManager: NSObject {
    
    private static let shared = RemoteAPIManager()
    // Block
    public typealias SignUpInBackgroundWithBlock = (Bool) -> Void
    public typealias LoginInBackgroundWithBlock = (Bool) -> Void

    private override init() {
        super.init()
    }
    
    class func signUp(request: UserRequest, withCompletion: @escaping SignUpInBackgroundWithBlock) {
        
        let user = PFUser()
        user.username = request.nickName
        user.password = request.password
        user.signUpInBackground { (isSucceeded, error) in
            withCompletion(isSucceeded)
        }
    }
    
    class func login(request: UserRequest, withCompletion: @escaping LoginInBackgroundWithBlock) {
        
        PFUser.logInWithUsername(inBackground: request.nickName, password: request.password) { (user, error) in
            withCompletion(user == nil ? false : true)
        }
    }
    
    
}
