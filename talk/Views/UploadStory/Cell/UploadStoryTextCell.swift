//
//  UploadStoryTextCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/07.
//

import UIKit

class UploadStoryTextCell: UITableViewCell {

    @IBOutlet weak var inputTextView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var title: String? {
        return inputTextView.text
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
