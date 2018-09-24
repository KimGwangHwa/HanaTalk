//
//  SideNormalCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/27.
//

import UIKit

enum SideNormalCellType {
    case none
    case browse
    case messages
    case setting
}

class SideNormalCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var badgeButton: UIButton!
    var type: SideNormalCellType = .none
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descriptionLabel.textColor = HanaWhiteTextColor
        let selectedView = UIView()
        selectedView.backgroundColor = HanaSelectedBackgroundColor
        selectedBackgroundView = selectedView
        addObserver()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - NotificationCenter
extension SideNormalCell {
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidReceive(notification:)), name: .PushNotificationDidRecive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidRead(notification:)), name: .PushNotificationDidRead, object: nil)

    }
    
    @objc func pushNotificationDidReceive(notification: Notification?) {
//        
//        if let userInfo = notification?.userInfo {
//            switch type {
//            case .browse:
//                break
//            case .messages:
//                if let pushType = userInfo[kPushNotificationType] as? String, pushType == MessageType.none {
//                    badgeButton.isHidden = false
//                }
//                
//                break
//            case .setting:
//                break
//                
//            default: break
//            }
//
//        }
    }
    
    @objc func pushNotificationDidRead(notification: Notification?) {

    }

}

