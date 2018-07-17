//
//  EventRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - Event
protocol EventRepository: Repository {
    typealias CompletionClosure = ((EventEntity?, Bool)-> Void)?
    typealias MultipleCompletionClosure = (([EventEntity]?, Bool)-> Void)?
    
    func find(by objectId: String, closure: CompletionClosure)
    
    func findAll(closure: MultipleCompletionClosure)
    
}

struct EventRepositoryImpl: EventRepository {
    
    let dao = EventDao()
    
    func find(by objectId: String, closure: EventRepository.CompletionClosure) {
        dao.find(by: objectId, closure: closure)
    }
    
    func findAll(closure: EventRepository.MultipleCompletionClosure) {
       dao.findAll(closure: closure)
    }
    
    func save(by object: BaseModel, closure: Repository.BoolClosure) {
        dao.save(by: object, closure: closure)
    }
}
