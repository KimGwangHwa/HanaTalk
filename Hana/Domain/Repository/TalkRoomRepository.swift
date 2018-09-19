//
//  TalkRoomRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - TalkRoomRepository
protocol TalkRoomRepository: Repository {

    func search(by receiver: String, closure: CompletionClosure)
    func create(with partner: String, closure: CompletionClosure)
}

struct TalkRoomRepositoryImpl: TalkRoomRepository {
    typealias Entity = TalkRoomEntity

    func search(by receiver: String, closure: CompletionClosure) {
        
    }
    
    func find(by objectId: String, closure: ((TalkRoomEntity?, Bool) -> Void)?) {
        
    }
    
    func create(with partner: String, closure: CompletionClosure) {
    }

}
