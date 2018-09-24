//
//  TalkRoomTranslator.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/08/18.
//

import UIKit

class TalkRoomTranslater: Translator {
    func translate(_ input: TalkRoomEntity?) -> TalkRoomModel? {
        if let input = input {
            let output = TalkRoomModel()
            output.objectId = input.objectId
            output.title = input.name
            output.lastMessage = input.lastMessage?.alert
            output.lastActiveDate = input.lastMessage?.createdAt?.string(format: .date)
            output.profileUrl = URL(string: input.members?.first?.profileUrl ?? "")
            return output
        }
        return nil
    }
}
