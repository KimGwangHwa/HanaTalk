//
//  EditUserInfoCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/22.
//

import UIKit

class EditUserInfoCell: UITableViewCell {

    var userInfo: UserInfo? {
        didSet {
            if let guardUserInfo = userInfo  {
                if let guardFile = guardUserInfo.profile {
                    guardFile.getDataInBackground(block: { (data, error) in
                        if let guardData = data {
                            self.profileImageView.image = UIImage(data: guardData)
                        }
                    })

//                    profileImageView.sd_setImage(with: URL(string: guardImageUrl), placeholderImage: nil)
                }
                nickNameTextField.text = guardUserInfo.nickName
                statusTextField.text = guardUserInfo.statusMessage
                birthdayTextField.text = Common.dateToString(date: guardUserInfo.birthday, format: DATE_FORMAT_2)
                emailTextField.text = guardUserInfo.email
                IDTextField.text = guardUserInfo.objectId
            }
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var statusTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var IDTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
