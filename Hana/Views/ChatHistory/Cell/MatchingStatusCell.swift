//
//  MatchingStatusCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit

class MatchingStatusCell: UICollectionViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var message: Message? {
        didSet {
            profileImageView.sd_setImage(with: URL(string: message?.sender?.profileUrl ?? ""), placeholderImage: nil)
            nicknameLabel.text = message?.sender?.nickname
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
