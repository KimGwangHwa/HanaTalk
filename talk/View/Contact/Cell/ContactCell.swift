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

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var user: User? {
        didSet {
            nickNameLabel.text = user?.nickName
            descriptionLabel.text = user?.statusMessage
            headImageView.sd_setImage(with: URL(string: user?.headImage ?? "")
                , placeholderImage: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
