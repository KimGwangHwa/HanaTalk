//
//  UserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/27.
//
//

import UIKit

class UserInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableview: UITableView!
    public var userData: User! = nil
    private var userInfoHeaderCell: UserInfoHeaderCell?
    
    private var headerCellHeight: CGFloat = 400.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeEvent(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    // CellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            userInfoHeaderCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userInfoHeaderCell.identifier, for: indexPath) as? UserInfoHeaderCell
            if let cell = userInfoHeaderCell {
                cell.infoData = userData
                return cell
            }
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return headerCellHeight
        }
        
        return 44
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let cell = userInfoHeaderCell {
            let offsetY = scrollView.contentOffset.y
            let offsetH = headerCellHeight + offsetY
            var frame = cell.frame
            frame.size.height = headerCellHeight - offsetY
            frame.origin.y = -headerCellHeight + offsetH
            cell.frame = frame

        }

    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
