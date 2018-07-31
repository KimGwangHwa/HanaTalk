//
//  InputMessageViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import UIKit
import RxCocoa
import RxSwift

class InputMessageViewController: UIViewController {

    var userInfoType: UserInfoType!

    var model: EditUserInfoModel!
    
    private let disposeBag = DisposeBag()
    
    private var displayValue: String? {
        set{
            switch userInfoType {
            case .nickname:
                model.nickname.accept(newValue ?? "")
                break
            case .bio:
                model.bio.accept(newValue ?? "")
                break
            case .email:
                model.mail.accept(newValue ?? "")
                break
            case .phoneNumber:
                model.tel.accept(newValue ?? "")
                break
            default:
                break
            }
        }
        get{
            switch userInfoType {
            case .nickname:
                return model.nickname.value
            case .bio:
                return model.bio.value
            case .email:
                return model.mail.value
            case .phoneNumber:
                return model.tel.value
            default:
                return nil
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let textViewCellIdentifier = R.reuseIdentifier.inputTextViewCell.identifier
    fileprivate let textFieldCellIdentifier = R.reuseIdentifier.inputTextFieldCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.inputTextViewCell(), forCellReuseIdentifier: textViewCellIdentifier)
        tableView.register(R.nib.inputTextFieldCell(), forCellReuseIdentifier: textFieldCellIdentifier)
        let rightButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedRightButton))
        rightButton.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = rightButton
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tappedRightButton() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table view data source
extension InputMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if userInfoType == .nickname || userInfoType == .email || userInfoType == .phoneNumber {
            if let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as? InputTextFieldCell {
                cell.textField.text = displayValue
                cell.textField.becomeFirstResponder()
                cell.textField.rx.text.map {$0 ?? ""}.subscribe { (event) in
                    self.displayValue = event.element
                    self.navigationItem.rightBarButtonItem?.isEnabled = !self.displayValue.isBlank
                }.disposed(by: disposeBag)
                return cell
            }
        }
        if userInfoType == .bio {
            if let cell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier, for: indexPath) as? InputTextViewCell {
                cell.textView.text = displayValue
                cell.textView.becomeFirstResponder()
                cell.textView.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

// MARK: - UITextViewDelegate
extension InputMessageViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        displayValue = textView.text
        navigationItem.rightBarButtonItem?.isEnabled = !displayValue.isBlank
    }
}


