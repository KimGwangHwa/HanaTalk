//
//  TalkRoomRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - TalkRoomRepository
protocol TalkRoomRepository: Repository {

    func find(by receiver: UserInfo, closure: CompletionClosure)
    
}
