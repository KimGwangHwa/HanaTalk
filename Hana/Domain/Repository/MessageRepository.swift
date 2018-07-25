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
    
}


struct MessageRepositoryImpl: MessageRepository {
    typealias Entity = MessageEntity
    
    func find(by talkRoom: TalkRoomEntity, closure: (([MessageRepositoryImpl.Entity]?, Bool) -> Void)?) {
        
    }
}
