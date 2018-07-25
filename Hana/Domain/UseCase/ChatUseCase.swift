//
//  ChatUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class ChatUseCase: NSObject {
    private let talkRepository = TalkRoomRepositoryImpl()
    private let likeRepository = LikeRepositoryImpl()
    private let translator = ChatTranslator()

    var data = [[ChatModel]]()
    
    func read(closure: @escaping (Bool)-> Void) {
        
        likeRepository.findAll { (entitys, isSuccess) in
            if let models = self.translator.translate(entitys) {
                self.data.append(models)
            }
            closure(isSuccess)
        }
        
        talkRepository.findAll { (entitys, isSuccess) in
            if let models = self.translator.translate(entitys) {
                self.data.append(models)
            }
            closure(isSuccess)
        }
    }
}
