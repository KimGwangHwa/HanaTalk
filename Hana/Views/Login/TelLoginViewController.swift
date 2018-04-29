//
//  TelLoginViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/28.
//

import UIKit

fileprivate let iconCellId = R.reuseIdentifier.telLoginIconCell.identifier
fileprivate let inputCellId = R.reuseIdentifier.telLoginInputCell.identifier
fileprivate let actionCellId = R.reuseIdentifier.telLoginActionCell.identifier

class TelLoginViewController: UIViewController {


    let idDataSource = [iconCellId, inputCellId, actionCellId]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUp()
    }
    
    func setUp() {
//        tableView.estimatedRowHeight = 100
//        tableView.rowHeight = UITableViewAutomaticDimension
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - TelLoginViewController
extension TelLoginViewController: UITableViewDelegate, UITableViewDataSource {
    
    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = idDataSource[indexPath.row]
        if identifier == iconCellId {
            if let iconCell = tableView.dequeueReusableCell(withIdentifier: iconCellId, for: indexPath) as? TelLoginIconCell {
                return iconCell
            }
        }
        
        if identifier == inputCellId {
            if let inputCell = tableView.dequeueReusableCell(withIdentifier: inputCellId, for: indexPath) as? TelLoginInputCell {
                return inputCell
            }
        }
        
        if identifier == actionCellId {
            if let actionCell = tableView.dequeueReusableCell(withIdentifier: actionCellId, for: indexPath) as? TelLoginActionCell {
                return actionCell
            }
        }
        return UITableViewCell()
    }
    
    // RowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idDataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
