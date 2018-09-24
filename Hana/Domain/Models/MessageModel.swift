//
//  MessageModel.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/15.
//

import UIKit

enum MessageType {
    case text(String)
    case image(String)
}

class MessageModel: BaseModel {
    var sendDate: String!
    var type:MessageType!
    var isSelf = false
    var profileImage: String?
    var profileUrl: URL!
    
    init(text: String) {
        super.init()
        self.type = .text(text)
        self.profileUrl = URL(string: DataManager.shared.currentUserInfo.profileUrl!)
    }
}
