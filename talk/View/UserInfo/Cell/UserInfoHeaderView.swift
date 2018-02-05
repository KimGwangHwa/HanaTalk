//
//  UserInfoHeaderView.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/28.
//

import UIKit

protocol UserInfoHeaderViewDelegate: class {
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapPosts atObject: UserInfo?)
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapFollowed atObject: UserInfo?)
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapFollowing atObject: UserInfo?)
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapEdit atObject: UserInfo?)
}

class UserInfoHeaderView: UICollectionReusableView {

    @IBOutlet weak var editButton: UIButton!
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
                
                Follow.countFollower(by: guardUserInfo.objectId) { (count, isSuccess) in
                    self.setAttributeTitleWithButton(self.followedCountButton, title: String(count))
                }
                Follow.countFollowing(by: guardUserInfo.objectId, completion: { (count, isSuccess) in
                    self.setAttributeTitleWithButton(self.followingCountButton, title: String(count))
                })
                Posts.countPosts(by: guardUserInfo, completion: { (count, isSuccess) in
                    self.setAttributeTitleWithButton(self.postsCountButton, title: String(count))
                })
                if let guardFile = guardUserInfo.profile {
                    guardFile.getDataInBackground(block: { (data, error) in
                        if let guardData = data {
                            self.imageView.image = UIImage(data: guardData)
                        }
                    })
                }
                nickNameLabel.text = guardUserInfo.nickname
                statusLabel.text = guardUserInfo.status
                if guardUserInfo.sex == true {
                    imageView.layer.borderColor = PinkColor.cgColor
                } else {
                    imageView.layer.borderColor = UIColor.black.cgColor
                }
            }
        }
    }
    
    @IBAction func editButtonEvent(_ sender: UIButton) {
        if delegate != nil {
            delegate?.userInfoHeaderView(self, didTapEdit: userinfo)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
}
