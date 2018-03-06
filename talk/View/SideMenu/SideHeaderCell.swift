//
//  SideHeaderCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/26.
//

import UIKit

protocol SideHeaderCellDelegate: class {
    func didTouchEditProfileButton(with Object: UserInfo?)
}

class SideHeaderCell: UITableViewCell {

    weak var delegate: SideHeaderCellDelegate?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var userInfo: UserInfo? {
        didSet {
            profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
            descriptionLabel.text = userInfo?.nickname
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func editProfileButton(_ sender: UIButton) {
        if let guardDelegate = delegate {
            guardDelegate.didTouchEditProfileButton(with: userInfo)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
