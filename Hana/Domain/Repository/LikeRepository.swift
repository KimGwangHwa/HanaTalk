//
//  LikeRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - LikeRepository
protocol LikeRepository: Repository {
    typealias CompletionClosure = ((Like?, Bool)-> Void)?
    typealias MultipleCompletionClosure = (([Like]?, Bool)-> Void)?
    
    func find(by objectId: String, closure: CompletionClosure)
    
    func find(likedBy userInfo: UserInfo, closure: CompletionClosure)
    
    func findAll(closure: MultipleCompletionClosure)
    
}
