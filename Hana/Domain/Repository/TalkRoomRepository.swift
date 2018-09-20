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
    private let dao = TalkRoomDao()

    func search(by receiver: String, closure: CompletionClosure) {
        dao.search(by: receiver, closure: closure)
    }
    
    func find(by objectId: String, closure: ((TalkRoomEntity?, Bool) -> Void)?) {
        dao.find(by: objectId, closure: closure)
    }
    
    func findAll(closure: (([TalkRoomEntity]?, Bool) -> Void)?) {
        dao.findAll(closure: closure)
    }
    
    func create(with partner: String, closure: CompletionClosure) {
        dao.create(with: partner, closure: closure)
    }
    
    func save(by object: TalkRoomEntity, closure: Repository.BoolClosure) {
        dao.save(by: object, closure: closure)
    }

}
