//
//  EditProfileCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/13.
//

import UIKit

protocol EditProfileCellDelegate: class {
    func didTouchChangeProfile()
}

class EditProfileCell: UITableViewCell {

    weak var delegate: EditProfileCellDelegate?
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func changeProfileButtonEvent(_ sender: UIButton) {
        if let guardDelegate = delegate {
            guardDelegate.didTouchChangeProfile()
        }
    }
    
}
