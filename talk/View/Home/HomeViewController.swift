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
        login()
    }
    
    func login() {
        
        if DataManager.shared.currentUser == nil {
            let userName = CoreDataManager.shared.loginInfo?.userName ?? ""
            let password = CoreDataManager.shared.loginInfo?.password ?? ""
            let request = UserRequest(userName: userName, password: password)
            
            RemoteAPIManager.shared.login(request: request, withCompletion: { (isSuccess) in
                self.connectRemoteChatServer()
            })

        } else {
            self.connectRemoteChatServer()
            
        }
    }
    
    func connectRemoteChatServer() {
        
        let userId = DataManager.shared.currentUser?.userName ?? ""
        
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
