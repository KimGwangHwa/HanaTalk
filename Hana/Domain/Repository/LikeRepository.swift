//
//  LikeRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

// MARK: - LikeRepository
protocol LikeRepository: Repository {
    
    func find(likedBy userInfo: UserInfoEntity, closure: CompletionClosure)
    
}
