//
//  LoginViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/07/31.
//
//

import UIKit
import Parse

class LoginViewController: UITableViewController {

    /// @IBOutlet
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        PFUser.logInWithUsername(inBackground: userIdTextField.text ?? "", password: passwordTextField.text ?? "") { (user, error) in
            if error == nil {
                UserInfo.findUserInfo(byUserObjectId: user?.objectId, completion: { (userInfo, isSuccess) in
                    userInfo?.pinInBackground()
                })
                if let viewController = R.storyboard.matching.matchingViewController() {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
