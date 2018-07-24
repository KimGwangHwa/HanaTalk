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
    
    func findCurrentFromLocal(closure: CompletionClosure)
}

struct UserInfoRepositoryImpl: UserInfoRepository {

    private let dao = UserInfoDao()
    typealias Entity = UserInfoEntity

    func findCurrent(closure: CompletionClosure) {
        dao.findCurrent(closure: closure)
    }
    
    func findCurrentFromLocal(closure: CompletionClosure) {
        dao.findCurrentFromLocal(closure: closure)
    }

    func find(by objectId: String, closure: ((UserInfoEntity?, Bool) -> Void)?) {
       dao.find(by: objectId, closure: closure)
    }
    
    func findAll(closure: MultipleCompletionClosure) {
        dao.findAll(closure: closure)
    }
    
    func save(by object: UserInfoEntity, closure: BoolClosure) {
        dao.save(by: object, closure: closure)
    }
}

