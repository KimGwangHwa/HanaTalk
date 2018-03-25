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
        let objectId = receiver?.objectId ?? ""
        let nickname = receiver?.nickname ?? ""
        
        PFCloud.callFunction(inBackground: SendPushFunction, withParameters: [
            kPushNotificationChannels : objectId,
            kPushNotificationAlert : nickname,
            kPushNotificationObjectId : objectId,
            kPushNotificationIsRead : false
        ]) { (response, error) in
            if let guardCompletion = completion {
                guardCompletion(error == nil ? true : false)
            }
        }
    }
    
    class func sendText(_ text: String?, receiver: UserInfo?, completion: ((Bool) -> Void)?) {
        let objectId = receiver?.objectId ?? ""
        let textString = text ?? ""
        PFCloud.callFunction(inBackground: SendPushFunction, withParameters: [
            kPushNotificationChannels : objectId,
            kPushNotificationAlert : textString,
            kPushNotificationText : textString,
            kPushNotificationType: PushNotificationType.text
            
        ]) { (response, error) in
            if let guardCompletion = completion {
                guardCompletion(error == nil ? true : false)
            }
        }

    }
    
    class func sendImage(_ image: UIImage?, receiver: UserInfo?, completion: ((Bool) -> Void)?) {
        let objectId = receiver?.objectId ?? ""
        let pffile = Common.imageToFile(image)
        pffile?.saveInBackground(block: { (isSuccess, error) in
            let imageUrl = pffile?.url ?? ""
            
            PFCloud.callFunction(inBackground: SendPushFunction, withParameters: [
                kPushNotificationChannels : objectId,
                kPushNotificationAlert : "image",
                kPushNotificationImageURL : imageUrl,
                kPushNotificationType: PushNotificationType.image
                
            ]) { (response, error) in
                if let guardCompletion = completion {
                    guardCompletion(error == nil ? true : false)
                }
            }

        })
        

    }
    
    class func didReceiveRemoteNotification(_ userInfo: [AnyHashable : Any]) {
        PFPush.handle(userInfo)
        NotificationCenter.default.post(name: .PushNotificationDidRecive, object: nil, userInfo: userInfo)
    }
    
}
