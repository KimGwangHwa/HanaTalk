//
//  LikeRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - LikeRepository
protocol LikeRepository: Repository {

    func save(by organizer: String, likedAt objectId: String, closure: BoolClosure)

    func save(by organizer: String, dislikedAt objectId: String, closure: BoolClosure)
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

    func save(by organizer: String, likedAt objectId: String, closure: BoolClosure) {
        dao.save(by: organizer, likedAt: objectId, closure: closure)
    }
    
    func save(by organizer: String, dislikedAt objectId: String, closure: BoolClosure) {
        dao.save(by: organizer, dislikedAt: objectId, closure: closure)
    }
    
    func save(by object: LikeEntity, closure: Repository.BoolClosure) {
        dao.save(by: object, closure: closure)
    }
    
}
