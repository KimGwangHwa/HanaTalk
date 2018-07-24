//
//  SideHeaderCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/26.
//

import UIKit

class SideHeaderCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var userInfo: UserInfoEntity? {
        didSet {
            profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: R.image.icon_profile())
            descriptionLabel.text = userInfo?.nickname
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
