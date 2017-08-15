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
    
    static let shared = RemoteAPIManager()

    // Block
    public typealias SignUpInBackgroundWithBlock = (Bool) -> Void
    public typealias LoginInBackgroundWithBlock = (Bool) -> Void

    private override init() {
        super.init()
        initParse()
    }
    
    private func initParse() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = SA_APPLICATIONID
            $0.clientKey = SA_CLIENT_KEY
            $0.server = SA_SERVER
        }
        Parse.initialize(with: configuration)

    }
    
    func signUp(request: UserRequest, withCompletion: @escaping SignUpInBackgroundWithBlock) {
        
        let user = PFUser()
        user.username = request.nickName
        user.password = request.password
        user.signUpInBackground { (isSucceeded, error) in
            withCompletion(isSucceeded)
        }
    }
    
    func login(request: UserRequest, withCompletion: @escaping LoginInBackgroundWithBlock) {

        PFUser.logInWithUsername(inBackground: request.id, password: request.password) { (user, error) in
            if user != nil {
                let loginHistory = LoginHistory.createNewRecord()
                loginHistory.userId = request.id
                loginHistory.password = request.password
                loginHistory.updateDate = NSDate()
                CoreDataManager.shared.saveContext()
            }
            withCompletion(user == nil ? false : true)
        }
    }
    
    
}
