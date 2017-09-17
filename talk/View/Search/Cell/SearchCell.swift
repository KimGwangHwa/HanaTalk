//
//  SearchCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/17.
//
//

import UIKit

class SearchCell: UITableViewCell {

    
    @IBOutlet weak var customView: CustomBadgeView!
    
    @IBOutlet weak var nickNaleLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
