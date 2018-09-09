//
//  LikeRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - LikeRepository
protocol LikeRepository: Repository {
    
    func liked(with objectId: String, closure: CompletionClosure)

    func disliked(with objectId: String, closure: CompletionClosure)
    
}

struct LikeRepositoryImpl: LikeRepository {
    private let dao = LikeDao()
    typealias Entity = LikeEntity
    
    func findAll(closure: (([Entity]?, Bool) -> Void)?) {
        dao.findAll(closure: closure)
    }
    
    func find(by objectId: String, closure: ((LikeEntity?, Bool) -> Void)?) {
        dao.find(by: objectId, closure: closure)
    }
    
    func liked(with objectId: String, closure: CompletionClosure) {
        dao.liked(with: objectId, closure: closure)
    }
    
    func disliked(with objectId: String, closure: CompletionClosure) {
        dao.disliked(with: objectId, closure: closure)
    }
    
    func save(by object: LikeEntity, closure: Repository.BoolClosure) {
        dao.save(by: object, closure: closure)
    }
}
