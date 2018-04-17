//
//  ParseHelper.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit
import Parse


enum PushNotificationType: Int {
    case like
    case message
}

fileprivate let applicationId = "ArTrHaVDOzyC4Wbr0up1BMnGfNauYTKhZunQZ1PK"
fileprivate let clientKey = "EUwwJWILGla9CLLHv8sKe6cicLU3HBYD8PyrARS1"
fileprivate let server = "https://parseapi.back4app.com"

class ParseHelper: NSObject {
    
    class func installations(with application: UIApplication) {
        let configuration = ParseClientConfiguration {
            $0.applicationId = applicationId
            $0.clientKey = clientKey
            $0.server = server
            $0.isLocalDatastoreEnabled = true
        }
        Parse.initialize(with: configuration)
        
        // notification
        let userNotificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.sound, UIUserNotificationType.badge]
        
        let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()

    }
    
    class func didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: Data) {

        let installation = PFInstallation.current()
        if let userInfo = DataManager.shared.currentuserInfo, let objectId = userInfo.objectId {
            installation?.addUniqueObject(objectId, forKey: "channels")
        }
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground()
    }
    
    // MARK: - Push Notification
    
    class func sendPush(with like: Like, completion: ((Bool) -> Void)? = nil) {
        let channel = like.liked?.objectId ?? ""
        let objectId = like.objectId!
        let alert = "liked by  \(like.likedBy?.nickname ?? "" )"
        sendPush(with: channel, objectId: objectId, alert: alert, type: .like, completion: completion)
    }
    class func sendPush(with message: Message, completion: ((Bool) -> Void)? = nil) {
        let channel = message.receiver?.objectId ?? ""
        let objectId = message.objectId!
        let alert = message.alert!
        sendPush(with: channel, objectId: objectId, alert: alert, type: .message, completion: completion)
    }
    
    class private func sendPush(with channel: String, objectId: String, alert: String, type: PushNotificationType, completion: ((Bool) -> Void)? = nil) {
        
        let push = PFPush()
        push.setChannel(channel)
        push.setData([
            kPushNotificationAlert : alert,
            kPushNotificationBadge : 1,
            kPushNotificationId : objectId,
            kPushNotificationType : type
            ])
        push.sendInBackground { (isSuccess, error) in
            if let guardCompletion = completion {
                guardCompletion(error == nil ? true : false)
            }
        }
    }
    
    class func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any]) {
//        PFPush.handle(userInfo)
        let objectId = userInfo[kPushNotificationId] as! String
        if let type = PushNotificationType(rawValue: userInfo[kPushNotificationType] as! Int) {
            switch type {
            case .like:
                LikeDao.find(by: objectId) { (like, isSuccess) in
                    if isSuccess == true {
                        like?.pinInBackground()
                        NotificationCenter.default.post(name: .PushNotificationDidRecive, object: like, userInfo: userInfo)
                    }
                }
                break
            case .message:
                MessageDao.find(by: objectId) { (message, isSuccess) in
                    if isSuccess == true {
                        message?.pinInBackground()
                        NotificationCenter.default.post(name: .PushNotificationDidRecive, object: message, userInfo: userInfo)
                    }
                }
                break
            }
        }
    }
    
}
