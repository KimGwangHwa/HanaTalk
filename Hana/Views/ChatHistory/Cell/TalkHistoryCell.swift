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
    
    var talkRoom: TalkRoom? {
        didSet {
            if let receiver = talkRoom?.members?.first {
                iconImageView.sd_setImage(with: URL(string: receiver.profileUrl ?? ""), placeholderImage: nil)
                talkNameLabel.text = receiver.nickname
            }
            talkDescriptionLabel.text = talkRoom?.lastMessage?.text
            talkDateLabel.text = talkRoom?.lastMessage?.createdAt?.string(format: .date)
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
    
}
