//
//  MessageRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - MessageRepository
protocol MessageRepository: Repository {
    
    func find(by talkRoom: TalkRoom, closure: MultipleCompletionClosure)
    
}
