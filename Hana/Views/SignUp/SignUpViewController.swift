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
    
    var isMan = true
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var womenButton: UIButton!
    @IBOutlet weak var menButton: UIButton!
    @IBOutlet weak var eMailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sexButtonEvent(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if womenButton.isSelected {
            menButton.isSelected = true
        } else if (menButton.isSelected) {
            womenButton.isSelected = true
        }
        if sender == womenButton && sender.isSelected {
            isMan = false
        } else {
            isMan = true
        }
    }
    
    @IBAction func submitEvent(_ sender: Any) {
        let signupUser = PFUser()
        signupUser.username = eMailTextField.text ?? ""
        signupUser.password = passwordTextField.text ?? ""
        signupUser.signUpInBackground { (isSuccess, error) in
            if isSuccess {
                
                let userinfo = UserInfo()
                userinfo.email = self.eMailTextField.text
                userinfo.sex = self.isMan
                userinfo.user = signupUser
                userinfo.nickname = self.nickNameTextField.text
                userinfo.saveInBackground(block: { (isSuccess, error) in
                    if isSuccess {
                        userinfo.pinInBackground()
                        if let viewController = R.storyboard.browse.browseViewController() {
                            self.navigationController?.pushViewController(viewController, animated: true)
                        }
                    }
                })
            }

        }
    }
    
}
