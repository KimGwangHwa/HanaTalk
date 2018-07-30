//
//  InputMessageViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import UIKit

class InputMessageViewController: UIViewController {

    var userInfoType: UserInfoType!
    private let userInfo = UserInfoDao.current()!
    var changedString: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    let textViewCellIdentifier = R.reuseIdentifier.inputTextViewCell.identifier
    let textFieldCellIdentifier = R.reuseIdentifier.inputTextFieldCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.inputTextViewCell(), forCellReuseIdentifier: textViewCellIdentifier)
        tableView.register(R.nib.inputTextFieldCell(), forCellReuseIdentifier: textFieldCellIdentifier)
        let rightButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(tappedRightButton))
        rightButton.tintColor = UIColor.black
        rightButton.isEnabled = false
        navigationItem.rightBarButtonItem = rightButton
        
        switch userInfoType {
        case .nickname:
            changedString = userInfo.nickname
            break
        case .bio:
            changedString = userInfo.bio
            break
        case .email:
            changedString = userInfo.email
            break
        case .phoneNumber:
            changedString = userInfo.phoneNumber
            break
        default:
            break
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func tappedRightButton() {
        switch userInfoType {
        case .nickname:
            userInfo.nickname = changedString
            break
        case .bio:
            userInfo.bio = changedString
            break
        case .email:
            userInfo.email = changedString
            break
        case .phoneNumber:
            userInfo.phoneNumber = changedString
            break
        default:
            break
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        changedString = sender.text
        if !changedString.isBlank {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

}

// MARK: - Table view data source
extension InputMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if userInfoType == .nickname || userInfoType == .email || userInfoType == .phoneNumber {
            if let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as? InputTextFieldCell {
                cell.textField.text = changedString
                cell.textField.becomeFirstResponder()
                cell.textField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
                return cell
            }
        }
        if userInfoType == .bio {
            if let cell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier, for: indexPath) as? InputTextViewCell {
                cell.textView.text = changedString
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
        changedString = textView.text
        if !changedString.isBlank {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
}


