//
//  ContactViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/03.
//
//

import UIKit

class ContactViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    // SectionTitles
    let sectionTitles = ["friend"]
    var dataSource = [User]()
    var selectedData: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getDataSource()
        
    }

    private func getDataSource() {
        RemoteAPIManager.shared.getFriends { (isSuccess, list) in
            if isSuccess {
                self.dataSource = list
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUpTableView() {
        tableView.register(R.nib.contactCell(), forCellReuseIdentifier: R.reuseIdentifier.contactCell.identifier)
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor.black
    }
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.contactViewController.userInfo.identifier {
            if let viewController = segue.destination as? UserInfoViewController {
                viewController.userData = selectedData
            }
        }
    }
    
    // MARK: - UITableViewDelegate
    
    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contactCell.identifier, for: indexPath) as? ContactCell
        cell?.user = dataSource[indexPath.row]
        return cell ?? UITableViewCell()
    }
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // RowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // SectionHeight
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    // SectionHeadView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headLabel = UILabel()
        headLabel.text = sectionTitles[section]
        headLabel.sizeToFit()
        return headLabel
    }
    
    // SectionIndex
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return ["A", "B", "C", "D", "E", "F", "G", "H"]
    }
    
    // DidSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedData = dataSource[indexPath.row]
        self.performSegue(withIdentifier: R.segue.contactViewController.userInfo.identifier, sender: nil)
    }
    
}
