//
//  ChatUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

protocol ChatDataStore {
    var likeModels: [ChatModel] { get }
    var talkModels: [TalkRoomModel] { get }
    var section: Int { get }
}

class ChatUseCase: NSObject {
    private let talkRepository = TalkRoomRepositoryImpl()
    private let likeRepository = LikeRepositoryImpl()
    private let translator = ChatTranslator()
    private let talkTranslator = TalkRoomTranslator()
    private var privateLikes = [ChatModel]()
    private var privateTalks = [TalkRoomModel]()

    func enterRoom(closure: @escaping (Bool)-> Void) {
        
    }
    
    func read(closure: @escaping (Bool)-> Void) {
        
        likeRepository.findAll { (entitys, isSuccess) in
            if let models = self.translator.translate(entitys) {
                self.privateLikes.append(contentsOf: models)
            }
            closure(isSuccess)
        }
        
        talkRepository.findAll { (entitys, isSuccess) in
            if let models = self.talkTranslator.translate(entitys) {
                self.privateTalks.append(contentsOf: models)
            }
            closure(isSuccess)
        }
    }
}

// MARK: - ChatDataStore
extension ChatUseCase: ChatDataStore {
    var likeModels: [ChatModel] {
        get {
            return privateLikes
        }
    }

    var talkModels: [TalkRoomModel] {
        get {
            return privateTalks
        }
    }
    
    var section: Int {
        get {
            var count = 0
            if likeModels.isEmpty { count += 1 }
            if talkModels.isEmpty { count += 1 }
            return count
        }
    }
}

