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
let profileCellIdentifier = R.reuseIdentifier.profileCell.identifier
let bioCellIdentifier = R.reuseIdentifier.bioCell.identifier
let contactInfoCellIdentifier = R.reuseIdentifier.contactInfoCell.identifier

class UserInfoViewController: UIViewController {

    var userInfo: UserInfo?
    @IBOutlet weak var tableView: UITableView!
    
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
    
    
    func loadRomoteData() {
        if userInfo == nil {
            UserInfo.findUserInfo(byObjectId: DataManager.shared.currentuserInfo?.objectId) { (userInfo, isSuccess) in
                self.userInfo = userInfo
                self.tableView.reloadData()
            }
        } else {
            self.navigationItem.leftBarButtonItem = nil
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButtonEvent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileCell {
                cell.profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
                cell.nickNameLabel.text = userInfo?.nickname
                cell.descriptionLabel.text = userInfo?.status
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: bioCellIdentifier, for: indexPath) as? BioCell {
                cell.bioLabel.text = userInfo?.bio
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: contactInfoCellIdentifier, for: indexPath) as? ContactInfoCell {
                cell.emailLabel.text = userInfo?.email
                cell.phoneNumberLabel.text = userInfo?.phoneNumber
                cell.birthdayLabel.text = Common.dateToString(date: userInfo?.birthday, format: DATE_FORMAT_2)
                //cell.sexLabel.text = (userInfo?.sex)! ? "man":"women"
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
