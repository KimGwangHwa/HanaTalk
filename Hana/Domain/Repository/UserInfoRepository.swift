//
//  UserInfoRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation
import UIKit

// MARK: - UserInfoRepository
protocol UserInfoRepository: Repository {
    
    static func current() -> UserInfoEntity?
    
    func findCurrent(closure: CompletionClosure)
    
    func findCurrentFromLocal(closure: CompletionClosure)
    
    func signin(username: String, password: String, closure: BoolClosure)
    
    func signup(username: String, password: String, closure: BoolClosure)
    
    func existence(username: String, closure: BoolClosure)
    
    func upload(image: UIImage, closure: BoolClosure)
}

struct UserInfoRepositoryImpl: UserInfoRepository {

    private let dao = UserInfoDao()
    typealias Entity = UserInfoEntity

    static func current() -> UserInfoEntity? {
        return UserInfoDao.current()
    }
    
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
    
    func signin(username: String, password: String, closure: BoolClosure) {
        dao.signin(username: username, password: password, closure: closure)
    }
    
    func signup(username: String, password: String, closure: BoolClosure) {
        dao.signup(username: username, password: password, closure: closure)
    }
    
    func existence(username: String, closure: BoolClosure) {
        dao.existence(username: username, closure: closure)
    }
    
    func upload(image: UIImage, closure: BoolClosure) {
        
    }
}

