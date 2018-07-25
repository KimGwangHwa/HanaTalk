//
//  SendMessageCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/28.
//
//

import UIKit

class SendTextCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var message: MessageEntity? {
        didSet {
            messageLabel.text = message?.text
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
