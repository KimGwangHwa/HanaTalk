//
//  SigUpViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/07/31.
//
//

import UIKit
import Parse

class SignUpViewController: UITableViewController {

    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitEvent(_ sender: Any) {
        let signupUser = User()
        signupUser.userName = userIdTextField.text ?? ""
        signupUser.password = passwordTextField.text ?? ""

        UserApi.signUp(user: signupUser) { (status) in
            if status == .success {
                if let viewController = R.storyboard.addUserInfo.addUserInfoViewController() {
                        self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
}
