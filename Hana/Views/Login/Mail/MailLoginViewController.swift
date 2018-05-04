//
//  MailLoginViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/03.
//

import UIKit

fileprivate let iconCellId = R.reuseIdentifier.loginIconCell.identifier
fileprivate let inputCellId = R.reuseIdentifier.mailLoginInputCell.identifier
fileprivate let actionCellId = R.reuseIdentifier.loginActionCell.identifier

class MailLoginViewController: UIViewController {
    
    let identifierDataSource = [iconCellId, inputCellId, actionCellId]

    private var mailTextField: UITextField!
    private var loginButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    func setUp() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.loginIconCell(), forCellReuseIdentifier: iconCellId)
        tableView.register(R.nib.mailLoginInputCell(), forCellReuseIdentifier: inputCellId)
        tableView.register(R.nib.loginActionCell(), forCellReuseIdentifier: actionCellId)

    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        loginButton.isEnabled = !(sender.text?.isEmpty)!
    }
    
    @objc func tappedLogin(_ sender: UIButton) {
        
        ParseHelper.loginFromEmail(with: mailTextField.text!)
        
        if let viewController = R.storyboard.enterVerificationCode.enterVerificationCodeViewController() {
            viewController.senderName = mailTextField.text
            present(viewController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MailLoginViewController: UITableViewDelegate, UITableViewDataSource {
    
    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = identifierDataSource[indexPath.row]
        if identifier == iconCellId {
            if let iconCell = tableView.dequeueReusableCell(withIdentifier: iconCellId, for: indexPath) as? LoginIconCell {
                return iconCell
            }
        }
        
        if identifier == inputCellId {
            if let inputCell = tableView.dequeueReusableCell(withIdentifier: inputCellId, for: indexPath) as? MailLoginInputCell {
                mailTextField = inputCell.mailTextField
                mailTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
                return inputCell
            }
        }
        
        if identifier == actionCellId {
            if let actionCell = tableView.dequeueReusableCell(withIdentifier: actionCellId, for: indexPath) as? LoginActionCell {
                loginButton = actionCell.loginButton
                loginButton.addTarget(self, action: #selector(tappedLogin(_:)), for: .touchUpInside)
                return actionCell
            }
        }
        return UITableViewCell()
    }
    
    // RowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifierDataSource.count
    }
}
