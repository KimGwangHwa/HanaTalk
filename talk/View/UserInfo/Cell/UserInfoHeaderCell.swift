//
//  UserInfoHeaderCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/27.
//
//

import UIKit

class UserInfoHeaderCell: UITableViewCell {

    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var statusMessageLabel: UILabel!
    @IBOutlet weak var sendMessageButton: UIButton!

    var infoData: UserInfo? {
        didSet {
            if let guardInfo = infoData {
                headImageView.sd_setImage(with: URL(string: guardInfo.profilePicture ?? ""), placeholderImage: nil)
                nickNameLabel.text = guardInfo.nickName
                statusMessageLabel.text = guardInfo.statusMessage
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
