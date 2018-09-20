//
//  ChattingUseCase.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/09.
//

import UIKit

protocol ChattingDataStore {
    func findTalkRoom(by partner: String)
    func enterTakRoom(with objectId: String)
    var messageModels: [MessageModel] { get }
}

protocol ChattingUseCase {
    func sendText(message: String?)
    func sendImage(message: UIImage?)
}

class ChattingUseCaseImpl: NSObject {
    private let talkRepo = TalkRoomRepositoryImpl()
    private let messageRepo = MessageRepositoryImpl()
    private let talkTrans = TalkRoomTranslater()

    private var talkRoom: TalkRoomEntity?
    private var partner: String?
    private var messages: [MessageModel]!
}

extension ChattingUseCaseImpl: ChattingUseCase {
    func sendText(message: String?) {
        guard let message = message else {
            return
        }
        if let talkRoom = talkRoom {
            messageRepo.create(with: talkRoom.objectId!, text: message) { (entity, isSuccess) in
                
            }
            return
        }
        talkRepo.create(with: partner!) { (entity, isSuccess) in
            if let entity = entity, isSuccess {
                self.talkRoom = entity
                self.messageRepo.create(with: entity.objectId!, text: message) { (entity, isSuccess) in
                    
                }
            }
        }
    }
    func sendImage(message: UIImage?) {
        
    }
}

// MARK: - ChattingDataStore
extension ChattingUseCaseImpl: ChattingDataStore {
    
    func findTalkRoom(by partner: String) {
        self.partner = partner
        talkRepo.search(by: partner) { (entity, isSuccess) in
            if let entity = entity, isSuccess {
                self.talkRoom = entity
            }
        }
    }
    func enterTakRoom(with objectId: String) {
        talkRepo.find(by: objectId) { (entity, isSuccess) in
            if let entity = entity, isSuccess {
                self.talkRoom = entity
            }
        }
    }
    var messageModels: [MessageModel] {
        return messages
    }
 }
