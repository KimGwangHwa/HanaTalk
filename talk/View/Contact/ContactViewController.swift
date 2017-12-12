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
    var dataSource = [UserInfo]()
    var selectedData: UserInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getDataSource()
    }
    
    // MARK: private


    private func getDataSource() {
//        RemoteAPIManager.shared.getFriends { (isSuccess, list) in
//            if isSuccess {
//                // TODO :
////                self.dataSource = list
//                self.tableView.reloadData()
//            }
//        }
    }
    
    private func setUpView() {
        // UITableView
        tableView.register(R.nib.contactCell(), forCellReuseIdentifier: R.reuseIdentifier.contactCell.identifier)
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor.black
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = 50.0
        
        // Navigation TODO:
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButton))
        
    }
    
    @objc private func rightBarButton() {
    
        performSegue(withIdentifier: R.segue.contactViewController.find.identifier, sender: nil)
    }
    
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.contactViewController.userInfo.identifier {
            if let viewController = segue.destination as? UserInfoViewController {
                // viewController.userId = selectedData?.userId ?? ""
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
