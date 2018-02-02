//
//  FindCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/23.
//
//

import UIKit

protocol FindCellDelegate: class {
    func findCell(_ cell: FindCell, didTapFollow atObject: UserInfo?)
}
class FindCell: UITableViewCell {

    weak var delegate: FindCellDelegate?

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var statusMessageLabel: UILabel!
    
    var userInfo: UserInfo? {
        didSet {
            if let guardUserInfo = userInfo {
                if let guardFile = guardUserInfo.profile {
                    guardFile.getDataInBackground(block: { (data, error) in
                        if let guardData = data {
                            self.iconImageView.image = UIImage(data: guardData)
                        }
                    })
//                    iconImageView.sd_setImage(with: URL(string: guardImageUrl)
//                        , placeholderImage: nil)
                }
                nickNameLabel.text = guardUserInfo.nickName
                statusMessageLabel.text = guardUserInfo.statusMessage
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func followButtonEvent(_ sender: UIButton) {
        if delegate != nil {
            delegate?.findCell(self, didTapFollow: userInfo)
        }
    }
    
}
