//
//  SplashViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/04.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        // getLocalUserInfo
        UserInfoDao.findCurrentFromLocal { (userInfo) in
            if let userInfo = userInfo {
                if !userInfo.configured {
                    self.moveToEditUserInfo()
                } else {
                    DataManager.shared.currentuserInfo = userInfo
                    self.moveToSideMenu()
                }
            } else {
                self.moveToLogin()
            }
        }

        debugPrint("SplashViewController")
    }
    
    func moveToEditUserInfo() {
        if let viewController = R.storyboard.editUserInfo.instantiateInitialViewController() {
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func moveToSideMenu() {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            let sidMenuViewController = SideMenuViewController.shared
            appdelegate.window?.rootViewController = sidMenuViewController
            appdelegate.window?.makeKeyAndVisible()
        }
    }
    
    func moveToLogin() {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate,
            let loginSelectionViewController = R.storyboard.loginSelection.loginSelectionViewController() {
            appdelegate.window?.rootViewController = loginSelectionViewController
            appdelegate.window?.makeKeyAndVisible()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
