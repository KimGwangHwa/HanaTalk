//
//  FindViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/23.
//
//

import UIKit

class FindViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [UserInfo]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    
    func searchFromRemoteData() {
        UserInfoApi.findUserInfo(by: nil, nickname: inputTextField.text) { (response) in
            if let guardUserInfo = response.data {
                self.dataSource = [guardUserInfo]
            }
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView() {
        tableView.register(R.nib.findCell(), forCellReuseIdentifier: R.reuseIdentifier.findCell.identifier)
        tableView.rowHeight = 70.0
    }
    
    
    @IBAction func CloseButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - tableView delegate
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.findCell
            .identifier, for: indexPath) as? FindCell

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
}

// MARK: - Navigation
extension FindViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchFromRemoteData()
        return true
    }
    
}

