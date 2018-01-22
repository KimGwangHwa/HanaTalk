//
//  EditUserInfoCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/22.
//

import UIKit

class EditUserInfoCell: UITableViewCell {

    @IBOutlet weak var infoImageView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
