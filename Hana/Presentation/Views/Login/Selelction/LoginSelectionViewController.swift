//
//  LoginSelectionViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/03.
//

import UIKit

fileprivate let iconCellId = R.reuseIdentifier.loginIconCell.identifier
fileprivate let selectionCellId = R.reuseIdentifier.loginSelectionCell.identifier

class LoginSelectionViewController: UIViewController {
    let identifierDataSource = [iconCellId, selectionCellId]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }
    
    func setUp() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.loginIconCell(), forCellReuseIdentifier: iconCellId)
        tableView.register(R.nib.loginSelectionCell(), forCellReuseIdentifier: selectionCellId)
    }

    @objc func tappedTelLoginButton(_ sender: UIButton) {
        if let viewController = R.storyboard.telLogin.telLoginViewController() {
            present(viewController, animated: true, completion: nil)
        }
    }
    
    @objc func tappedMailLoginButton(_ sender: UIButton) {
        if let viewController = R.storyboard.mailLogin.mailLoginViewController() {
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension LoginSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = identifierDataSource[indexPath.row]
        if identifier == iconCellId {
            if let iconCell = tableView.dequeueReusableCell(withIdentifier: iconCellId, for: indexPath) as? LoginIconCell {
                return iconCell
            }
        }
        
        if identifier == selectionCellId {
            if let selectionCell = tableView.dequeueReusableCell(withIdentifier: selectionCellId, for: indexPath) as? LoginSelectionCell {
                selectionCell.loginTelButton.addTarget(self, action: #selector(tappedTelLoginButton(_:)), for: .touchUpInside)
                selectionCell.loginMailButton.addTarget(self, action: #selector(tappedMailLoginButton(_:)), for: .touchUpInside)
                return selectionCell
            }
        }
        return UITableViewCell()
    }
    
    // RowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return identifierDataSource.count
    }
}
