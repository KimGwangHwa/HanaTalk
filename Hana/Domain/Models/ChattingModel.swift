//
//  ChattingModel.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/09.
//

import UIKit

enum MessageType {
    case text(String)
    case image(String)
}

class ChattingModel: BaseModel {
    var sendDate: String!
    var type:MessageType!
}
