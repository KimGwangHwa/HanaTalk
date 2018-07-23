//
//  UserInfoRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - UserInfoRepository
protocol UserInfoRepository: Repository {
    
    func findCurrent(closure: CompletionClosure)
}

struct UserInfoRepositoryImpl: UserInfoRepository {

    typealias Entity = UserInfo

    func find(by objectId: String, closure: CompletionClosure) {
    }
    
    func findCurrent(closure: CompletionClosure) {

    }
    
    func findAll(closure: MultipleCompletionClosure) {
        
    }

    func save(by object: Entity, closure: BoolClosure) {
        
    }
}

