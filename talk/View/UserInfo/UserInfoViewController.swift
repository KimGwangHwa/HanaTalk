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

    public var userId: String = ""
    //R.reuseIdentifier.followerCell
    
    private var cellIdentifiers: [String] = [R.reuseIdentifier.profileCell.identifier, R.reuseIdentifier.postsCell.identifier, R.reuseIdentifier.followingCell.identifier, R.reuseIdentifier.followerCell.identifier]
    private var userInfo: UserInfo? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        if userId.isEmpty {
            userId = DataManager.shared.currentUserObjectId
        }
        RemoteAPIManager.shared.getUserInfo(with: userId) { (isSuccess, info) in
            self.userInfo = info
            self.tableview.reloadData()
        }
    }
    
    func setUpView() {
        tableview.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    @IBAction func sendMessageEvent(_ sender: UIButton) {
        
        if let topViewController = self.topNavigationViewController() {
            if let viewController = R.storyboard.talkRoom.talkRoomViewController() {
                viewController.receiverUserId = userInfo?.userId ?? ""
                topViewController.pushViewController(viewController, animated: false)
            }
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    // MARK: - UITableViewDelegate
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cellIdentifiers.count
        }
        return 1

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // CellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as? UserInfoCell {
            cell.userInfo = userInfo
            return cell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cellIdentifiers[indexPath.row] == R.reuseIdentifier.profileCell.identifier {
            return 100
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    // SectionHeadView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headLabel = UILabel()
        headLabel.text = "test"
        headLabel.sizeToFit()
        return headLabel
    }

    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if let cell = userInfoHeaderCell {
//            let offsetY = scrollView.contentOffset.y
//            let offsetH = headerCellHeight + offsetY
//            var frame = cell.frame
//            frame.size.height = headerCellHeight - offsetY
//            frame.origin.y = -headerCellHeight + offsetH
//            cell.frame = frame
//
//        }
//
//    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
