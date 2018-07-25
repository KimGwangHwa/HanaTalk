//
//  TalkRoomRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - TalkRoomRepository
protocol TalkRoomRepository: Repository {

    func find(by receiver: UserInfoEntity, closure: CompletionClosure)
    
}

struct TalkRoomRepositoryImpl: TalkRoomRepository {
    typealias Entity = TalkRoomEntity

    func find(by receiver: UserInfoEntity, closure: ((TalkRoomEntity?, Bool) -> Void)?) {
        
    }
    
    func find(by objectId: String, closure: ((TalkRoomEntity?, Bool) -> Void)?) {
        
    }
    
    
    
}
