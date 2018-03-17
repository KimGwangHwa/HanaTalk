//
//  TalkHistoryViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/25.
//

import UIKit

class TalkHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let historyCellIdentifier = R.reuseIdentifier.talkHistoryCell.identifier
    let matchingCellIdentifier = R.reuseIdentifier.matchingCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        
    }

    func setUpView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.talkHistoryCell(), forCellReuseIdentifier: historyCellIdentifier)
        tableView.register(R.nib.matchingCell(), forCellReuseIdentifier: matchingCellIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func sideMenuEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension TalkHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: matchingCellIdentifier, for: indexPath) as? MatchingCell {
                return cell
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as? TalkHistoryCell {
            return cell
        }
        
        
        return UITableViewCell()
    }

    
}

