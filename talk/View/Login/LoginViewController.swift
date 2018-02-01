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
            if error != nil {
                if let viewController = R.storyboard.home.homeViewController() {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}
