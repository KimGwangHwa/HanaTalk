//
//  TalkRoomTranslator.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/08/18.
//

import UIKit

class TalkRoomTranslator: Translator {
    func translate(_ input: TalkRoomEntity?) -> ChatModel? {
        if let input = input {
            let output = ChatModel()
            output.name = input.name
            output.lastMessage = input.lastMessage?.alert
            output.lastActiveDate = input.lastMessage?.createdAt?.string(format: .date)
            output.profileUrl = input.members?.first?.profileUrl
            return output
        }
        return nil
    }
    

}
