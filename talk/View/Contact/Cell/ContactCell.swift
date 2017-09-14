//
//  ContactCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/03.
//
//

import UIKit
import SDWebImage

class ContactCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var customBadgeView: CustomBadgeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    var user: User? {
        didSet {
            nickNameLabel.text = user?.nickName
            descriptionLabel.text = user?.statusMessage
            customBadgeView.imageView.sd_setImage(with: URL(string: user?.headImage ?? "")
                , placeholderImage: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
