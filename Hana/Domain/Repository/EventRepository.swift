//
//  EventRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - Event
struct EventRepositoryImpl: Repository {
    typealias Entity = EventEntity
    
    private let dao = EventDao()
    
    func find(by objectId: String, closure: CompletionClosure) {
        dao.find(by: objectId, closure: closure)
    }
    
    func findAll(closure: MultipleCompletionClosure) {
       dao.findAll(closure: closure)
    }

    func save(by object: Entity, closure: Repository.BoolClosure) {
        dao.save(by: object, closure: closure)
    }

}
