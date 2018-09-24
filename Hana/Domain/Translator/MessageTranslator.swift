//
//  ChattingTranslator.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/15.
//

import UIKit

class MessageTranslator: Translator {
    func translate(_ input: MessageEntity?) -> MessageModel? {
        if let input = input {
            let output = MessageModel()
            let isSelf = input.sender?.objectId == DataManager.shared.currentUserInfo.objectId
            output.isSelf = isSelf
            output.profileUrl = URL(string: input.sender?.profileUrl ?? "")
            if let text = input.text {
                output.type = .text(text)
            }
            if let image = input.imageURL {
                output.type = .image(URL(string: image)!)
            }
            output.sendDate = input.createdAt?.string(format: .date)
            return output
        }
        return nil
    }
}
