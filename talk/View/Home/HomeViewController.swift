//
//  HomeViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/25.
//
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        connectRemoteChatServer()
    }
    
    func connectRemoteChatServer() {
        guard let currentUser = DataManager.shared.currentUser else {
            return
        }
        RemoteChatManager.shared.connect(userId: currentUser.objectId) { (isSuccess) in
            
            for itemViewController in self.viewControllers ?? [] {
                if let navViewController = itemViewController as? UINavigationController {
                    if let navRootViewController = navViewController.viewControllers.first {
//                        if let asTalkLogViewController = navRootViewController as? TalkLogViewController {
//                            RemoteChatManager.shared.addDelegate(asTalkLogViewController)
//                        }
                    }
                }
                
            }
            
            RemoteChatManager.shared.addDelegate(self)

        }
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
