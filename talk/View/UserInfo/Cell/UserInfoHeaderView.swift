//
//  UserInfoHeaderView.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/28.
//

import UIKit

protocol UserInfoHeaderViewDelegate: class {
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapPosts object: Any)
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapFollowed object: Any)
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapFollowing object: Any)
}

class UserInfoHeaderView: UICollectionReusableView {

    weak var delegate: UserInfoHeaderViewDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var postsCountButton: UIButton!
    @IBOutlet weak var followedCountButton: UIButton!
    @IBOutlet weak var followingCountButton: UIButton!
    
    let stringBoldAttributes: [NSAttributedStringKey : Any] = [
        .foregroundColor : UIColor.black,
        .font : UIFont.systemFont(ofSize: 24.0)
    ]
    let stringNormalAttributes: [NSAttributedStringKey : Any] = [
        .foregroundColor : UIColor.gray,
        .font : UIFont.systemFont(ofSize: 14.0)
    ]
    
    func setAttributeTitleWithButton(_ button: UIButton, title: String) {
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(string: title + "\n", attributes: stringBoldAttributes))
        switch button {
        case postsCountButton:
            attributedString.append(NSAttributedString(string: "Posts", attributes: stringNormalAttributes))
        case followedCountButton:
            attributedString.append(NSAttributedString(string: "Followed", attributes: stringNormalAttributes))

        case followingCountButton:
            attributedString.append(NSAttributedString(string: "Following", attributes: stringNormalAttributes))
        default: break
        }
        button.setAttributedTitle(attributedString, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
    }
    
    var userinfo: UserInfo? {
        didSet {
            if let guardUserInfo = userinfo {
                setAttributeTitleWithButton(postsCountButton, title: String(guardUserInfo.postsCount))
                setAttributeTitleWithButton(followingCountButton, title: String(guardUserInfo.followingCount))
                setAttributeTitleWithButton(followedCountButton, title: String(guardUserInfo.followersCount))
                if let guardImageUrl = guardUserInfo.profileImage {
                    imageView.sd_setImage(with: URL(string: guardImageUrl)
                        , placeholderImage: nil)
                }
                nickNameLabel.text = guardUserInfo.nickName
                statusLabel.text = guardUserInfo.statusMessage
                if guardUserInfo.sex == true {
                    imageView.layer.borderColor = PinkColor.cgColor
                } else {
                    imageView.layer.borderColor = UIColor.black.cgColor
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
}
