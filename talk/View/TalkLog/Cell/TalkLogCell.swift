//
//  TalkLogCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit

class TalkLogCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
