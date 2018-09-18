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
            output.subObjectId = input.organizer.objectId
            output.matched = input.matched.contains(where: {$0.objectId == UserInfoDao.current()!.objectId})
            return output 
        }
        return nil
    }
    
}
