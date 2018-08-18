//
//  ChatTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class ChatTranslator: Translator {
    typealias Input = LikeEntity
    
    typealias Output = ChatModel

    func translate(_ input: Input?) -> Output? {
        if let input = input {
            let output = ChatModel()
            output.name = input.organizer.nickname
            output.profileUrl = input.organizer.profileUrl
            output.detailObjectId = input.organizer.objectId
            return output 
        }
        return nil
    }
    
}
