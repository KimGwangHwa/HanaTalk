//
//  InfoInputViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/30.
//

import UIKit

class InfoInputViewController: UIViewController {

    enum InfoType {
        case nickName
        case statusMessage
        case phoneNumber
        case email
        case sex
        
        var placeholder: String {
            
            switch self {
            case .nickName:
                return "input your nickname"
            case .statusMessage:
                return "input your statusMessage"
            case .phoneNumber:
                return "input your phoneNumber"
            case .email:
                return "input your email"
            case .sex:
                return "input your sex"
            }
        }
    }
    
    public var type: InfoType = .nickName
    
    public var placeholder = ""
    
    @IBOutlet weak var infoInputTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneEvent))
        infoInputTextField.placeholder = type.placeholder
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        infoInputTextField.leftView = leftView
        infoInputTextField.leftViewMode = .always
    }

    func doneEvent() {
        var userInfo = DataManager.shared.currentUserInfo
        
        if userInfo == nil {
            userInfo = UserInfo()
        }

        switch type {
        case .nickName:
            userInfo?.nickName = infoInputTextField.text
            break
        case .statusMessage:
            userInfo?.statusMessage = infoInputTextField.text
            break
        case .phoneNumber:
            userInfo?.phoneNumber = infoInputTextField.text
            break
        case .email:
            userInfo?.phoneNumber = infoInputTextField.text
            break
        case .sex:
            userInfo?.phoneNumber = infoInputTextField.text
            break
        }
        
        userInfo?.saveInBackground(block: { (isSuccess, error) in
            self.navigationController?.popViewController(animated: true)
        })
        
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
