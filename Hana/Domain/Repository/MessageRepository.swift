//
//  MessageRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - MessageRepository
protocol MessageRepository: Repository {
    
    func find(by talkRoom: TalkRoomEntity, closure: MultipleCompletionClosure)
    func create(with talkRoom: TalkRoomEntity, text: String, closure: CompletionClosure)
}


struct MessageRepositoryImpl: MessageRepository {
    typealias Entity = MessageEntity
    
    func find(by talkRoom: TalkRoomEntity, closure: (([MessageRepositoryImpl.Entity]?, Bool) -> Void)?) {
        
    }
    
    func create(with talkRoom: TalkRoomEntity, text: String, closure: CompletionClosure) {

    }

}
