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
}
