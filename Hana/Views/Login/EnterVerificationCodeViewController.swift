//
//  EnterVerificationCodeViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/29.
//

import UIKit

class EnterVerificationCodeViewController: UIViewController {

    var senderName: String?
    
    @IBOutlet weak var sendtoLabel: UILabel!
    @IBOutlet weak var code1textField: UITextField!
    @IBOutlet weak var code2textField: UITextField!
    @IBOutlet weak var code3textField: UITextField!
    @IBOutlet weak var code4textField: UITextField!
    
    private var isDidAppear: Bool = false
    var textFields: [UITextField]!
    override func viewDidLoad() {
        super.viewDidLoad()
        textFields = [code1textField, code2textField, code3textField, code4textField]
        sendtoLabel.text = R.string.localizable.sentTo(senderName!)
        code1textField.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isDidAppear = true
    }
    
    @IBAction func tappedResend(_ sender: UIButton) {
        
    }

    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        if let index = textFields.index(of: sender) {
            let afterIndex = textFields.index(after: index)
            textFields[afterIndex].becomeFirstResponder()
        }
    }
}
