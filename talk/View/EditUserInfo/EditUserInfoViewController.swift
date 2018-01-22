//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/22.
//

import UIKit

class EditUserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        tableView.register(R.nib.editUserInfoCell(), forCellReuseIdentifier: R.reuseIdentifier.editUserInfoCell.identifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension EditUserInfoViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.editUserInfoCell.identifier, for: indexPath) as? EditUserInfoCell {
            return cell
        }
        return UITableViewCell()
    }
    
}
