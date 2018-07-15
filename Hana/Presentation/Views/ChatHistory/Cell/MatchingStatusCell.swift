//
//  MatchingStatusCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit

class MatchingStatusCell: UICollectionViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    var model: Like! {
        didSet {
            bgImageView.isHidden = model.matched
            profileImageView.sd_setImage(with: URL(string: model.receiver.profileUrl ?? ""), placeholderImage: nil)
            nicknameLabel.text = model.likedBy?.nickname
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        nicknameLabel.adjustsFontSizeToFitWidth = true
    }

}
