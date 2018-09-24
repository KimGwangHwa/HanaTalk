//
//  MessageModel.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/15.
//

import UIKit
import RxCocoa
import RxSwift

enum MessageType {
    case text(String)
    case image(String)
}

enum MessageState {
    case sending
    case failure
    case success
}

class MessageModel: BaseModel {
    var sendDate: String!
    var type:MessageType!
    var isSelf = false
    var profileImage: String?
    var profileUrl: URL!
    var state = BehaviorRelay<MessageState>(value: .sending)

    init(text: String) {
        super.init()
        self.type = .text(text)
        self.profileUrl = URL(string: DataManager.shared.currentUserInfo.profileUrl!)
    }
}
