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

        connectRemoteChatServer()
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
