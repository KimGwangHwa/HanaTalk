//
//  MessageRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - MessageRepository
protocol MessageRepository: Repository {
    typealias CompletionClosure = ((Message?, Bool)-> Void)?
    typealias MultipleCompletionClosure = (([Message]?, Bool)-> Void)?
    
    func find(by objectId: String, closure: CompletionClosure)
    
    func find(by talkRoom: TalkRoom, closure: MultipleCompletionClosure)
    
    func findAll(closure: MultipleCompletionClosure)
}
