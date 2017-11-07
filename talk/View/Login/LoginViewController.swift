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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapLoginButton(_ sender: UIButton) {

//        let dao = UserDao()
//        dao.login(user: <#T##User#>) { (response) in
//
//        }
        
//        User.login(with: userIdTextField.text ?? "", password: passwordTextField.text ?? "") { (status) in
//            if status == .Success {
//                self.performSegue(withIdentifier: self.homeSegueIdentifier, sender: nil)
//            }
//        }
    }
}
