//
//  ProfileCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/08.
//

import UIKit

protocol ProfileCellDelegate: class {
    func didTouchEditProfile()
    func didTouchLike()
    func didTouchDelte()
}

class ProfileCell: UITableViewCell {

    weak var delegate: ProfileCellDelegate?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func editButtonEvent(_ sender: UIButton) {
        if let guardDelegate = delegate {
            guardDelegate.didTouchEditProfile()
        }
    }
    
    @IBAction func tappedHeart(_ sender: UIButton) {
    }
    
    @IBAction func tappedDelete(_ sender: UIButton) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func eventButtonEvent(_ sender: UIButton) {
        
    }
}
