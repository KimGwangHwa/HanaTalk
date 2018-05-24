//
//  InputMessageViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import UIKit

class InputMessageViewController: UIViewController {

    var inputType: InputType!
    
    @IBOutlet weak var tableView: UITableView!
    
    let textViewCellIdentifier = R.reuseIdentifier.inputTextViewCell.identifier
    let textFieldCellIdentifier = R.reuseIdentifier.inputTextFieldCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.inputTextViewCell(), forCellReuseIdentifier: textViewCellIdentifier)
        tableView.register(R.nib.inputTextFieldCell(), forCellReuseIdentifier: textFieldCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Table view data source
extension InputMessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if inputType == .text {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier) else {
                return UITableViewCell()
            }
            return cell
        }
        if inputType == .longText {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textViewCellIdentifier) else {
                return UITableViewCell()
            }
            return cell
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

