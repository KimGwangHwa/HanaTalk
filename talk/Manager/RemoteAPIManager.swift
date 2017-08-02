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
    private static var isInit = false
    // Block
    public typealias SignUpInBackgroundWithBlock = (Bool) -> Void
    public typealias LoginInBackgroundWithBlock = (Bool) -> Void

    private override init() {
        super.init()
    }
    
    private class func initParse() {
        if !isInit {
            let configuration = ParseClientConfiguration {
                $0.applicationId = SA_APPLICATIONID
                $0.clientKey = SA_CLIENT_KEY
                $0.server = SA_SERVER
            }
            Parse.initialize(with: configuration)

            isInit = true
        }
    }
    
    class func signUp(request: UserRequest, withCompletion: @escaping SignUpInBackgroundWithBlock) {
        RemoteAPIManager.initParse()
        
        let user = PFUser()
        user.username = request.nickName
        user.password = request.password
        user.signUpInBackground { (isSucceeded, error) in
            withCompletion(isSucceeded)
        }
    }
    
    class func login(request: UserRequest, withCompletion: @escaping LoginInBackgroundWithBlock) {
        RemoteAPIManager.initParse()

        PFUser.logInWithUsername(inBackground: request.id, password: request.password) { (user, error) in
            withCompletion(user == nil ? false : true)
        }
    }
    
    
}
