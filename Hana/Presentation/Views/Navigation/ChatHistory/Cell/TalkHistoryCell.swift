//
//  TalkHistoryCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/25.
//

import UIKit

class TalkHistoryCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var talkNameLabel: UILabel!
    @IBOutlet weak var talkDateLabel: UILabel!
    @IBOutlet weak var talkDescriptionLabel: UILabel!
    @IBOutlet weak var talkBageLabel: UILabel!
    
    var model: TalkRoomModel! {
        didSet {
            iconImageView.sd_setImage(with: model.profileUrl, placeholderImage: nil)
            talkNameLabel.text = model.title
            talkDescriptionLabel.text = model.lastMessage
            talkDateLabel.text = model.lastActiveDate
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let selectedView = UIView()
        selectedView.backgroundColor = HanaSelectedBackgroundColor
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
