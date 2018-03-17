//
//  ParseHelper.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit
import Parse

class ParseHelper: NSObject {
    
    static let shared = ParseHelper()
    
    private override init() {
        super.init()
    }
    
    class func installations(with application: UIApplication) {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "ArTrHaVDOzyC4Wbr0up1BMnGfNauYTKhZunQZ1PK"
            $0.clientKey = "EUwwJWILGla9CLLHv8sKe6cicLU3HBYD8PyrARS1"
            $0.server = "https://parseapi.back4app.com"
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
    

}
