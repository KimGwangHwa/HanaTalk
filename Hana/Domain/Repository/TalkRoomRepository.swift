//
//  TalkRoomRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - TalkRoomRepository
protocol TalkRoomRepository: Repository {
    typealias CompletionClosure = ((TalkRoom?, Bool)-> Void)?
    typealias MultipleCompletionClosure = (([TalkRoom]?, Bool)-> Void)?
    
    func find(by objectId: String, closure: CompletionClosure)
    
    func find(by receiver: UserInfo, closure: CompletionClosure)
    
    func findAll(closure: MultipleCompletionClosure)
    
    func save(by reciver: UserInfo, lastMessage: Message, closure: BoolClosure)
}
