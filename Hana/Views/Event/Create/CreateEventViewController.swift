//
//  CreateEventViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/12.
//

import UIKit

class CreateEventViewController: UITableViewController {

    
    let nameCellIdentifier = R.reuseIdentifier.createEventNameCell.identifier
    let normalCellIdentifier = R.reuseIdentifier.createEventNormalCell.identifier
    let detaillCellIdentifier = R.reuseIdentifier.createEventDetailCell.identifier
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        tableView.register(R.nib.createEventNameCell(), forCellReuseIdentifier: nameCellIdentifier)
        tableView.register(R.nib.createEventNormalCell(), forCellReuseIdentifier: normalCellIdentifier)
        tableView.register(R.nib.createEventDetailCell(), forCellReuseIdentifier: detaillCellIdentifier)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: nameCellIdentifier, for: indexPath) as? CreateEventNameCell {
            return cell
        }
        return UITableViewCell()
    }
    
    
}
