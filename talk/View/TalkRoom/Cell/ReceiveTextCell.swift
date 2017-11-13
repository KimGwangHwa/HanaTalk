//
//  ReceiveMessageCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/28.
//
//

import UIKit

class ReceiveTextCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var message: Message? {
        didSet {
            messageLabel.text = message?.textMessage
        }
    }
    
    var receiver: UserInfo? {
        didSet {
            headImageView.sd_setImage(with: URL(string: receiver?.profileImageUrl ?? ""), placeholderImage: nil)
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
