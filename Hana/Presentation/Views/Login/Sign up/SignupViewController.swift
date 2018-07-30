//
//  SignupViewController.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/27.
//

import UIKit

class SignupViewController: UIViewController {

    private let usecase = LoginUseCase()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var usernameExistenceImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        scrollView.backgroundColor = BackgroundColor
        signupButton.setTitleColor(WeakTextColor, for: .normal)
        
        signupButton.setBackgroundImage(UIImage.colorImage(color: DisabelColor, size: CGSize(width: 100, height: 100)), for: .disabled)
        signupButton.setBackgroundImage(UIImage.colorImage(color: MainColor, size: CGSize(width: 100, height: 100)), for: .normal)

        usernameTextField.rx.controlEvent(UIControlEvents.editingDidEnd).asDriver().drive(onNext: { (event) in
            self.usecase.existenceUsername(closure: { (isSuccess) in
                self.usernameExistenceImageView.image = isSuccess ? #imageLiteral(resourceName: "icon_signup_check_mark"):#imageLiteral(resourceName: "icon_signup_x_mark")
                self.usernameExistenceImageView.isHidden = false
            })
        }).disposed(by: usecase.disposeBag)
        
        _ = usernameTextField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.username)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.password)
        _ = confirmPasswordTextField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.confirmPassword)

        usecase.signupValueChanged { (isEmpty) in
            self.signupButton.isEnabled = !isEmpty
        }

    }

    @IBAction func signupTapped(_ sender: UIButton) {
        usecase.signup { (isSuccess) in
            self.moveToEditUserInfo()
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func moveToEditUserInfo() {
        if let viewController = R.storyboard.editUserInfo.instantiateInitialViewController() {
            present(viewController, animated: true, completion: nil)
        }
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
