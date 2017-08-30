//
//  HomeViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/25.
//
//

import UIKit

class HomeViewController: UITabBarController, DidReceiveMessageDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        connectRemoteChatServer()
        RemoteChatManager.shared.addDelegate(self)
    }
    
    func connectRemoteChatServer() {
        
        let userId = CoreDataManager.shared.loginInfo?.userName ?? ""
        
        RemoteChatManager.shared.connect(userId: userId) { (isSuccess) in
            
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - DidReceiveMessageDelegate
    
    func didReceiveMessage(_ message: Message?, isSuccess: Bool) {
        self.viewControllers?[1].tabBarItem.badgeValue = "100"
//        tabBar.items[1].
//        if let item = tabBar.items[1] {
//            item
//        }
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
