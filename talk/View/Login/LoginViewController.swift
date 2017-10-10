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
    
    let homeSegueIdentifier = R.segue.loginViewController.home.identifier

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapLoginButton(_ sender: UIButton) {
        let request = UserRequest(userName: userIdTextField.text ?? "", password: passwordTextField.text ?? "")
        RemoteAPIManager.shared.login(request: request) { (isSucceeded) in
            if isSucceeded {
                self.performSegue(withIdentifier: self.homeSegueIdentifier, sender: nil)
            }
        }
    }

    // MARK: Segue Prepare
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}
