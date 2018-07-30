//
//  NotificationManager.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/27.
//

import UIKit
import UserNotifications
import Parse

class NotificationManager: NSObject {
    
    static let shared = NotificationManager()
    
    // push ReceiveData
    var pushReceiveData: [AnyHashable : Any]!
    
    var receiveObjectId : String? {
        return pushReceiveData[kPushNotificationId] as? String
    }
    
    var receiveType: PushNotificationType? {
        return PushNotificationType(rawValue: pushReceiveData[kPushNotificationType] as! Int)
    }

    private override init() {
        super.init()
        
    }
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            if error != nil {
                return
            }
            
            if granted {
                // OK
            } else {
                // NG

            }
        })
    }

    func sendPush(with channels: [String]?, objectId: String, alert: String, type: PushNotificationType, completion: ((Bool) -> Void)? = nil) {
        
        let push = PFPush()
        if let currentUserInfo = UserInfoDao.current() {
            push.setChannels(channels?.filter({$0 != currentUserInfo.objectId!}))
        }
        push.setData([
            kPushNotificationAlert : alert,
            kPushNotificationBadge : 1,
            kPushNotificationId : objectId,
            kPushNotificationType : type.rawValue
            ])
        push.sendInBackground { (isSuccess, error) in
            if let guardCompletion = completion {
                guardCompletion(error == nil ? true : false)
            }
        }
    }
    
    
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        debugPrint("userNotificationCenter")
    }
        
    // fore
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound, .badge])
        self.pushReceiveData = notification.request.content.userInfo
        NotificationCenter.default.post(name: .PushNotificationDidRecive, object: nil, userInfo: nil)

        debugPrint("withCompletionHandler")

    }
}

