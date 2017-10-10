//
//  UserInfoCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/27.
//
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var customBadgeView: CustomBadgeView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    var userInfo: UserInfo? {
        didSet {
            if let guradUserInfo = userInfo {
                customBadgeView.imageView.sd_setImage(with: URL(string: guradUserInfo.profilePicture ?? ""), placeholderImage: nil)

                if nickNameLabel != nil {
                    nickNameLabel.text = "\(String(guradUserInfo.nickName ?? ""))"
                }
                
                if statusLabel != nil {
                    statusLabel.text = "\(String(guradUserInfo.statusMessage ?? ""))"
                }
                
                if phoneNumberLabel != nil {
                    phoneNumberLabel.text = "\(String(guradUserInfo.phoneNumber ?? ""))"
                }
                
                if emailLabel != nil {
                    emailLabel.text = "\(String(guradUserInfo.email ?? ""))"
                }
                if sexLabel != nil {
                    sexLabel.text = "\(String(guradUserInfo.sex ? "Man" : "Women"))"
                }

                if birthdayLabel != nil {
                    birthdayLabel.text = Common.dateToString(date: guradUserInfo.birthday, format: DATE_FORMAT_2)
                }                
                //
                if postsLabel != nil {
                    postsLabel.text = "\(String(guradUserInfo.postsCount ?? 0))"
                }
//
                if followingLabel != nil {
                    followingLabel.text = "\(String(guradUserInfo.followingCount ?? 0))"
                }
//
                if followerLabel != nil {
                    followerLabel.text = "\(String(guradUserInfo.followersCount ?? 0))"
                }
                
            }
        }
    }

}
