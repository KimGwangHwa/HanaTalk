//
//  FindCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/23.
//
//

import UIKit

class FindCell: UITableViewCell {

    @IBOutlet weak var iconImageView: CustomBadgeView!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var statusMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
