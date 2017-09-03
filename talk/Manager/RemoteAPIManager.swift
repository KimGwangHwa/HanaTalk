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

    typealias CompletionHandler = (Bool) -> Void
    typealias GetListCompletionHandler = (Bool, [User]) -> Void

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
    
    func signUp(request: UserRequest, withCompletion: @escaping CompletionHandler) {
        
        let user = PFUser()
        user.username = request.nickName
        user.password = request.password
        user.signUpInBackground { (isSucceeded, error) in
            withCompletion(isSucceeded)
        }
    }
    
    func login(request: UserRequest, withCompletion: @escaping CompletionHandler) {

        PFUser.logInWithUsername(inBackground: request.userName, password: request.password) { (user, error) in
            if user != nil {
                
                let currentUser = User()
                currentUser.userName = user?.username ?? ""
                currentUser.nickName = (user?["nickName"] as? String) ?? ""
                currentUser.headImage = (user?["headImage"] as? PFFile)?.url
                currentUser.statusMessage = user?["statusMessage"] as? String
                currentUser.email = user?["email"] as? String

                DataManager.shared.currentUser = currentUser
                
                let loginHistory = LoginHistory.createNewRecord()
                loginHistory.userName = request.userName
                loginHistory.password = request.password
                loginHistory.updateDate = NSDate()
                CoreDataManager.shared.saveContext()
            }
            withCompletion(user == nil ? false : true)
        }
    }
    
    func getFriends(completionHandler: @escaping GetListCompletionHandler) {
        let query = PFQuery(className: "Friend")
        query.whereKey("userName", equalTo: "test")
        query.findObjectsInBackground { (objects, error) in
            var userIds = [String]()
            for item in objects ?? [] {
                if let pfObj = item["friendUser"] as? PFObject {
                    userIds.append(pfObj.objectId ?? "")
                }
            }
            var retUser = [User]()
            
            let queryUser = PFQuery(className: "_User")
            queryUser.whereKey("objectId", containedIn: userIds)
            queryUser.findObjectsInBackground(block: { (users, error) in
                for item in users ?? [] {
                    let user = User()
                    user.userName = (item["username"] as? String) ?? ""
                    user.nickName = (item["nickName"] as? String) ?? ""
                    user.statusMessage = (item["statusMessage"] as? String) ?? ""
                    if let file = item["headImage"] as? PFFile {
                        user.headImage = file.url
                    }
                    
                    retUser.append(user)
                }
                
                DataManager.shared.friends = retUser
                
                completionHandler(true, retUser)

            })
            
            
        }
    }
    
    func saveRemoteClass(message: Message) {
//        let pfObject = PFObject(className: "Messages");
//        pfObject["sender"] = PFObject(withoutDataWithClassName: "_User", objectId: message.sender);
//        pfObject["receiveer"] = PFObject(withoutDataWithClassName: "_User", objectId: message.receiveer);
//        pfObject["textMessage"] = message.textMessage
//        pfObject["fileMessage"] = message.fileMessage
//        pfObject["messageFalg"] = message.messageFalg.rawValue
//        pfObject["isRead"] = message.isRead
        
//        pfObject.saveInBackground { (isSuccess, error) in
//            
//        }
    }
    
    func saveRemoteClass(user: User)  {
        
    }
    
    
}
