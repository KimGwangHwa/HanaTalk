//
//  TalkLogCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit

class TalkLogCell: UITableViewCell {

    @IBOutlet weak var customBadgeView: CustomBadgeView!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var data: ChatRoom? {
        didSet{
            
            if let guardData = data {
                if let guardMembers = guardData.members {
                    if let firstObject =  guardMembers.first {
                        if let opponentUser = DataManager.shared.friends.filter({$0.userName == firstObject}).first {
                            customBadgeView.imageView.sd_setImage(with: URL(string: opponentUser.headImage ?? "")
                                , placeholderImage: nil)
                            roomNameLabel.text = data?.name
                        }
                    }
                }
                
                customBadgeView.badgeString = String("\(guardData.unreadMessageCount)")
                
                if let lastMessage = Message.find(objectId: guardData.lastMessageId) {
                    lastMessageLabel.text = lastMessage.textMessage
                    dateLabel.text = Common.dateToString(date: lastMessage.createdAt ?? Date(), format: "M/d")
                    
                }
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
    
}
