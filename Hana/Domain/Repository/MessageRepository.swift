//
//  MessageRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - MessageRepository
protocol MessageRepository: Repository {
    
    func find(by talkRoomObjectId: String, closure: MultipleCompletionClosure)
    func create(with talkRoomObjectId: String, text: String, closure: CompletionClosure)
}


struct MessageRepositoryImpl: MessageRepository {
    typealias Entity = MessageEntity
    
    func find(by talkRoomObjectId: String, closure: (([MessageRepositoryImpl.Entity]?, Bool) -> Void)?) {
        
    }
    
    func create(with talkRoomObjectId: String, text: String, closure: CompletionClosure) {

    }

}
