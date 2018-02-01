//
//  LoginViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/07/31.
//
//

import UIKit

class LoginViewController: UITableViewController {

    /// @IBOutlet
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let user = User()
        user.userName = userIdTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        UserApi.login(user: user) { (status) in
            if status == .success {
                UserInfoApi.findCurrentUserInfo(by: DataManager.shared.currentUser?.objectId, completion: { (response) in
                    if response.status == .success {
                        if response.data == nil {
                            self.performSegue(withIdentifier: R.segue.loginViewController.signUp.identifier, sender: nil)
                        } else {
                            if let viewController = R.storyboard.home.homeViewController() {
                                self.navigationController?.pushViewController(viewController, animated: true)
                            }
                        }
                    }
                })
            }
        }
    }
}
