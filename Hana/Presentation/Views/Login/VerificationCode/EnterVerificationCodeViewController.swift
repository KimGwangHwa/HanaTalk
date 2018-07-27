//
//  EnterVerificationCodeViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/29.
//

import UIKit
import Parse

class EnterVerificationCodeViewController: UIViewController {

    var senderName: String!
    let emptyString = " "
    let maxIndex = 4
    @IBOutlet weak var sendtoLabel: UILabel!
    @IBOutlet weak var code1textField: UITextField!
    @IBOutlet weak var code2textField: UITextField!
    @IBOutlet weak var code3textField: UITextField!
    @IBOutlet weak var code4textField: UITextField!
    
    var textFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        textFields = [code1textField, code2textField, code3textField, code4textField]
        code1textField.text = emptyString
        code2textField.text = emptyString
        code3textField.text = emptyString
        code4textField.text = emptyString
        
        sendtoLabel.text = R.string.localizable.sentTo(senderName)
        code1textField.becomeFirstResponder()
    }
    
    func confrimLoginCode() {
        if let code1 = code1textField.text,
            let code2 = code2textField.text,
            let code3 = code3textField.text,
            let code4 = code4textField.text {
            let loginCode = (code1 + code2 + code3 + code4).replacingOccurrences(of: emptyString, with: "")
            if loginCode.count == maxIndex {
                loginProcessing(with: loginCode)
            }
        }
    }
    
    func loginProcessing(with password: String) {
        PFUser.logInWithUsername(inBackground: senderName, password: password) { (user, error) in
            if error == nil {
                self.moveToNext()
            }
        }
    }
    
    func moveToNext() {
        UserInfoDao().findCurrent { (entity, isSuccess) in
            if let userInfo = entity {
                
                userInfo.pinInBackground()
                self.view.endEditing(true)
                if !userInfo.configured {
                    if let viewController = R.storyboard.editUserInfo.instantiateInitialViewController() {
                        self.present(viewController, animated: true, completion: nil)
                    }
                } else {
                    if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
                        let sidMenuViewController = SideMenuViewController.shared
                        appdelegate.window?.rootViewController = sidMenuViewController
                        appdelegate.window?.makeKeyAndVisible()
                    }
                }
            }
        }
    }
    
    @IBAction func tappedResend(_ sender: UIButton) {
        
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        let  char = sender.text?.cString(using: .utf8)
        let isBackSpace = strcmp(char, "\\b")
        if (sender.text == emptyString || isBackSpace == -92) {
            // previous
            if let index = textFields.index(of: sender) {
                let beforeIndex = textFields.index(before: index)
                if !(beforeIndex < 0) {
                    if (sender.text?.isEmpty)! {
                        textFields[beforeIndex].becomeFirstResponder()
                        textFields[beforeIndex].text = emptyString
                    }
                }
                sender.text = emptyString
            }
            
        } else {
            // next
            if let index = textFields.index(of: sender) {
                let afterIndex = textFields.index(after: index)
                if afterIndex < textFields.count {
                    textFields[afterIndex].becomeFirstResponder()
                }
            }
        }
        confrimLoginCode()
    }
}
