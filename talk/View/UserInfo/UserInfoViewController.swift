//
//  UserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit

enum InfoSection: Int {
    
    case profile = 0
    case bio = 1
    case contactInfo = 2
    case keyWord = 3
    
    static var sectionCount: Int {
        return 4
    }
    
    func rowCount(isEditMode: Bool = false) -> Int {
        switch self {
        case .profile:
            return 1
        case .contactInfo:
            if isEditMode == true {
                return 6
            }
            return 4
        case .keyWord:
            return 1
        case .bio:
            return 1
        }
    }
    
    var sectionName: String {
        switch self {
        case .profile:
            return ""
        case .contactInfo:
            return "Contact Info"
        case .keyWord:
            return "Key Word"
        case .bio:
            return "Bio"
        }
    }
}

class UserInfoViewController: UITableViewController {

    var userInfo: UserInfo?
    @IBOutlet weak var keyWordLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var infoFullNameLabel: UILabel!
    @IBOutlet weak var infoEmailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadRomoteData()
    }
    
    func setUpView() {
//        profileImageView.layer.borderWidth = 1
//        profileImageView.layer.borderColor = UIColor.gray.cgColor
        tableView.tableFooterView = UIView(frame: .zero)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func loadDataOfView() {
        profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
        fullNameLabel.text = userInfo?.nickname
        emailLabel.text = userInfo?.email
        infoEmailLabel.text = userInfo?.email
        infoFullNameLabel.text = userInfo?.nickname
        phoneNumberLabel.text = userInfo?.phoneNumber
        keyWordLabel.text = userInfo?.keyword
        bioLabel.text = userInfo?.bio
        tableView.reloadData()
    }
    
    func loadRomoteData() {
        UserInfo.findUserInfo(byObjectId: DataManager.shared.currentuserInfo?.objectId) { (userInfo, isSuccess) in
            self.userInfo = userInfo
            self.loadDataOfView()
        }
//        if let guardUserInfo = DataManager.shared.currentuserInfo {
//            userInfo = guardUserInfo
//            self.setUpView()
//        } else {
//            UserInfo.findUserInfo(byObjectId: DataManager.shared.currentuserInfo?.objectId) { (userInfo, isSuccess) in
//                self.userInfo = userInfo
//                self.setUpView()
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuButtonEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return InfoSection.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let enumInfo = InfoSection(rawValue: section) {
            return enumInfo.rowCount()
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
 
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let sectionHeaderView = UIView()
//        let sectionLabel : UILabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.width, height: 28))
//        if let enumInfo = InfoSection(rawValue: section) {
//            sectionLabel.text = enumInfo.sectionName
//            sectionLabel.backgroundColor = UIColor.white
//            sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        }
//        sectionHeaderView.addSubview(sectionLabel)
//        return sectionHeaderView
//    }
}
