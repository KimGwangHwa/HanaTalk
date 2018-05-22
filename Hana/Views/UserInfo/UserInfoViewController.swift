//
//  UserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit

fileprivate let profileCellIdentifier = R.reuseIdentifier.profileCell.identifier
fileprivate let albumCellIdentifier = R.reuseIdentifier.userInfoAlbumCell.identifier

class UserInfoViewController: UIViewController {

    var userInfo: UserInfo!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadRomoteData()
    }
    
    func setUpView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(R.nib.profileCell(), forCellReuseIdentifier: profileCellIdentifier)
        tableView.register(R.nib.userInfoAlbumCell(), forCellReuseIdentifier: albumCellIdentifier)
        
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(R.image.more(), for: .normal)
        rightButton.addTarget(self, action: #selector(tappedMore), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func tappedMore() {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Edit Profile", style: .default, handler: { (action) in
            if let viewController = R.storyboard.editUserInfo.editUserInfoViewController() {
                self.present(viewController, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (action) in

        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
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
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileCell {
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: albumCellIdentifier, for: indexPath) as? UserInfoAlbumCell {
                cell.reload(with: .horizontal, dataSource: userInfo)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return UserInfoAlbumCell.height(with: .horizontal, dataSource: userInfo)
        }
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 3 {
            if let viewController = R.storyboard.hobbySelection.hobbySelectionViewController() {
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

// MARK: - ProfileCellDelegate
extension UserInfoViewController: ProfileCellDelegate {
    func didTouchLike() {
        
    }
    
    func didTouchDelte() {
        
    }
    
    func didTouchEditProfile() {
        if let editUserInfo = R.storyboard.editUserInfo.editUserInfoViewController() {
            present(editUserInfo, animated: true, completion: nil)
        }
    }
    
}

