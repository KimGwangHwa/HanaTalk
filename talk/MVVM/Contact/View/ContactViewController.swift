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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setUpTableView() {
        tableView.register(R.nib.contactCell(), forCellReuseIdentifier: R.reuseIdentifier.contactCell.identifier)
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexColor = UIColor.black
    }
    
    // MARK: - UITableViewDelegate
    
    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.contactCell.identifier, for: indexPath) as? ContactCell
        return cell ?? UITableViewCell()
    }
    
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    // RowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
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
    
}
