//
//  MailLoginViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/03.
//

import UIKit

fileprivate let iconCellId = R.reuseIdentifier.telLoginIconCell.identifier
fileprivate let inputCellId = R.reuseIdentifier.telLoginInputCell.identifier
fileprivate let actionCellId = R.reuseIdentifier.telLoginActionCell.identifier

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
        
    }
    
    @objc func textFieldDidChanged(_ sender: UITextField) {
        loginButton.isEnabled = !(sender.text?.isEmpty)!
    }
    

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MailLoginViewController: UITableViewDelegate, UITableViewDataSource {
    
    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = identifierDataSource[indexPath.row]
        if identifier == iconCellId {
            if let iconCell = tableView.dequeueReusableCell(withIdentifier: iconCellId, for: indexPath) as? MailIconCell {
                return iconCell
            }
        }
        
        if identifier == inputCellId {
            if let inputCell = tableView.dequeueReusableCell(withIdentifier: inputCellId, for: indexPath) as? MailInputCell {
                mailTextField = inputCell.mailTextField
                mailTextField.addTarget(self, action: #selector(textFieldDidChanged(_:)), for: .editingChanged)
                return inputCell
            }
        }
        
        if identifier == actionCellId {
            if let actionCell = tableView.dequeueReusableCell(withIdentifier: actionCellId, for: indexPath) as? MailActionCell {
                loginButton = actionCell.loginButton
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
