//
//  SigninViewController.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/27.
//

import UIKit
import RxSwift
import RxCocoa

class SigninViewController: UIViewController {

    private let usecase = LoginUseCase()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        _ = usernameTextField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.username)
        _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.password)

        usecase.valueChanged { (isEmpty) in
            self.signinButton.isEnabled = !isEmpty
        }
        scrollView.backgroundColor = UIColor.hex("f2f2f0")
        signinButton.setBackgroundImage(UIImage.colorImage(color: DisabelColor, size: CGSize(width: 100, height: 100)), for: .disabled)
        signinButton.setBackgroundImage(UIImage.colorImage(color: MainColor, size: CGSize(width: 100, height: 100)), for: .normal)
        
        NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillShow).asObservable().subscribe { (notification) in

            let info  = notification.element!.userInfo!
            let value = info[UIKeyboardFrameEndUserInfoKey]! as! CGRect
            
            self.didChangeScrollView(height: value.size.height)

            }.disposed(by: usecase.disposeBag)
        
        NotificationCenter.default.rx.notification(NSNotification.Name.UIKeyboardWillHide).asObservable().subscribe { (notification) in
                self.returnScrollView()
            }.disposed(by: usecase.disposeBag)
        
    }
    
    
    private func didChangeScrollView(height: CGFloat) {
        scrollView.contentOffset = CGPoint(x: 0, y: height)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
    }
    
    private func returnScrollView() {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scrollViewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func signinTapped(_ sender: UIButton) {
        usecase.sginin { (isSuccess) in
            
        }
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
