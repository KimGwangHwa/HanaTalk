//
//  UserInfoRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - UserInfoRepository
protocol UserInfoRepository: Repository {
    typealias CompletionClosure = ((UserInfo?, Bool)-> Void)?
    typealias MultipleCompletionClosure = (([UserInfo]?, Bool)-> Void)?
    
    func find(by objectId: String, closure: CompletionClosure)
    
    func findCurrent(closure: CompletionClosure)
    
    func findAll(closure: MultipleCompletionClosure)
}

struct UserInfoRepositoryImpl: UserInfoRepository {

    func find(by objectId: String, closure: UserInfoRepository.CompletionClosure) {
    }
    
    func findCurrent(closure: UserInfoRepository.CompletionClosure) {

    }
    
    func findAll(closure: UserInfoRepository.MultipleCompletionClosure) {
        
    }

    func save(by object: BaseModel, closure: Repository.BoolClosure) {
        
    }
}

