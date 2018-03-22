//
//  ParseHelper.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit
import Parse


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
    
    class func sendLiked(with receiver: UserInfo?, completion: ((Bool) -> Void)?) {
        PFCloud.callFunction(inBackground: SendPushFunction, withParameters: [
            "channel" : receiver?.objectId ?? "",
            "message" : "like of" + (receiver?.nickname)!
            ])
    }
    
    class func sendText(_ text: String?, receiver: UserInfo?, completion: @escaping  (Bool) -> Void) {
        let push = PFPush()
        push.setChannel(receiver?.objectId ?? "")
        push.setMessage(text)
        push.sendInBackground { (isSuccess, error) in
            completion(isSuccess)
        }

    }
    
    class func sendImage(_ image: UIImage?, receiver: UserInfo?, completion: @escaping  (Bool) -> Void) {
        let push = PFPush()
        push.setChannel(receiver?.objectId ?? "")
        //push.setData()
        push.sendInBackground { (isSuccess, error) in
            completion(isSuccess)
        }
    }
    
    class func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any]) {
        PFPush.handle(userInfo)
        NotificationCenter.default.post(name: .PushNotificationDidRecive, object: nil, userInfo: userInfo)
    }
    
}
