//
//  AppDelegate.swift
//  talk
//
//  Created by ひかりちゃん on 2017/07/31.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        if let notificationPayload = launchOptions?[UIApplicationLaunchOptionsKey.remoteNotification] as? NSDictionary {
//        }
        ParseHelper.installations(with: application)

//        let query = PFQuery(className:"UserInfo")
//        query.whereKey("nickName", equalTo:"nickName")
//        query.fromLocalDatastore()
//        query.findObjectsInBackground { (objects, error) in
//
//        }
//        return true
//        let a = PFObject(withoutDataWithClassName: "_User", objectId: "RRcC6BJkX1")
//
//        let obj = PFObject(className: "UserInfo")
//
//        obj["user"] = a
//        obj["nickName"] = "nickName"
//
//        obj.saveInBackground { (issuccess, error) in
//
//        }
//        do {
//            try obj.pin()
//        } catch  {
//
//        }
//
//
//                let query = PFQuery(className:"UserInfo")
//                query.whereKey("nickName", equalTo:"nickName")
//                query.fromLocalDatastore()
//                query.findObjectsInBackground { (objects, error) in
//
//                }
//
//        return true
//
        if DataManager.shared.currentUser != nil {
            
            
            let sidMenuViewController = SideMenuViewController.shared
            self.window?.rootViewController = sidMenuViewController
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        ParseHelper.didRegisterForRemoteNotificationsWithDeviceToken(deviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        ParseHelper.didReceiveRemoteNotification(userInfo)
    }
}
