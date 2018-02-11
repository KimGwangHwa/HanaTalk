//
//  FindViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/23.
//
//

import UIKit

class FindViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let showUserInfo = R.segue.findViewController.showUserInfo.identifier
    var dataSource: [UserInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func searchFromRemoteData() {
        UserInfo.findUserInfo(byNickName: inputTextField.text) { (userInfo, isSuccess) in
            if let guardUserInfo = userInfo {
                self.dataSource = [guardUserInfo]
            }
            self.tableView.reloadData()
        }
    }
    
    func setUpView() {
        tableView.register(R.nib.findCell(), forCellReuseIdentifier: R.reuseIdentifier.findCell.identifier)
        tableView.rowHeight = 70.0
    }
    
    
    @IBAction func CloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showUserInfo {
            if let userInfoViewController = segue.destination as? UserInfoViewController {
                //userInfoViewController.userInfo = sender as? UserInfo
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FindViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.findCell
            .identifier, for: indexPath) as? FindCell
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showUserInfo, sender: dataSource?[indexPath.row])
    }
}


// MARK: - UITextFieldDelegate
extension FindViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchFromRemoteData()
        return true
    }
    
}

