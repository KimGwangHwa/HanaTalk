//
//  UserInfoCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/27.
//
//

import UIKit

class UserInfoCell: UITableViewCell {

    @IBOutlet weak var profileImageView: CustomBadgeView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followerCountLabel: UILabel!
    
    var userInfo: UserInfo? {
        didSet {
            if let guradUserInfo = userInfo {
                
                if profileImageView != nil ,nickNameLabel != nil, statusLabel != nil {
                    profileImageView.imageView.sd_setImage(with: URL(string: guradUserInfo.profilePicture ?? ""), placeholderImage: nil)
                    nickNameLabel.text = guradUserInfo.nickName
                    statusLabel.text = guradUserInfo.statusMessage
                }
                
                if postsCountLabel != nil {
                    postsCountLabel.text = "\(String(guradUserInfo.postsCount ?? 0))"
                }
                
                if followingCountLabel != nil {
                    followingCountLabel.text = "\(String(guradUserInfo.followingCount ?? 0))"
                }

                if followerCountLabel != nil {
                    followerCountLabel.text = "\(String(guradUserInfo.followersCount ?? 0))"
                }
                
            }
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
