//
//  UserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit

fileprivate let profileCellIdentifier = R.reuseIdentifier.profileCell.identifier
fileprivate let bioCellIdentifier = R.reuseIdentifier.bioCell.identifier
fileprivate let contactInfoCellIdentifier = R.reuseIdentifier.contactInfoCell.identifier
fileprivate let userInfoHobbyCellIdentifier = R.reuseIdentifier.userInfoHobbyCell.identifier

class UserInfoViewController: UIViewController {

    var userInfo: UserInfo!
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
        tableView.register(R.nib.userInfoHobbyCell(), forCellReuseIdentifier: userInfoHobbyCellIdentifier)
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func loadRomoteData() {
        if let objectId = userInfo.objectId {
            UserInfoDao.findUserInfo(by: objectId) { (userInfo, isSuccess) in
                self.userInfo = userInfo
                self.tableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tappedMenu(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    @IBAction func tappedAlbum(_ sender: UIButton) {
    }
    
    @IBAction func closeButtonEvent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileCell {
                cell.profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: R.image.icon_profile())
                cell.nickNameLabel.text = userInfo?.nickname
                cell.delegate = self
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: bioCellIdentifier, for: indexPath) as? BioCell {
                cell.bioLabel.text = userInfo?.bio
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: contactInfoCellIdentifier, for: indexPath) as? ContactInfoCell {
                cell.nicknameLabel.text = userInfo?.nickname
                cell.emailLabel.text = userInfo?.email
                cell.phoneNumberLabel.text = userInfo?.phoneNumber
                cell.birthdayLabel.text = Common.dateToString(date: userInfo?.birthday, format: DATE_FORMAT_2)
                if let sex = userInfo?.sex {
                    cell.sexLabel.text = sex ? "man":"women"
                }
                return cell
            }
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: userInfoHobbyCellIdentifier, for: indexPath) as? UserInfoHobbyCell {
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

// MARK: - ProfileCellDelegate
extension UserInfoViewController: ProfileCellDelegate {
    func didTouchEditProfile() {
        if let editUserInfo = R.storyboard.editUserInfo.editUserInfoViewController() {
            present(editUserInfo, animated: true, completion: nil)
        }
    }
}

