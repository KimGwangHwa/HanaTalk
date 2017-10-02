//
//  UserProfileCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/02.
//

import UIKit

class UserProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: CustomBadgeView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    
//    var image: String? {
//        didSet {
//            profileImageView.imageView.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: nil)
//            
//        }
//        
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
