//
//  EditContactInfoCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/13.
//

import UIKit

class EditContactInfoCell: UITableViewCell {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

