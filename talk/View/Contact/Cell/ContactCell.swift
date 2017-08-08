//
//  ContactCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/03.
//
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var userInfo: UserInfo? {
        didSet {
            nickNameLabel.text = userInfo?.nickName
            descriptionLabel.text = userInfo?.statusMessage
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
