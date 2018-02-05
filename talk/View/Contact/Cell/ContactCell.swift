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
    var user: UserInfo? {
        didSet {
            nickNameLabel.text = user?.nickname
            descriptionLabel.text = user?.status
            user?.profile?.getDataInBackground(block: { (data, error) in
                if let guardData = data {
                    self.customBadgeView.imageView.image = UIImage(data: guardData)
                }
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
