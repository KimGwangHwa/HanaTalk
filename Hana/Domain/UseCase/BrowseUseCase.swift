//
//  BrowseUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class BrowseUseCase: NSObject {
    var data: [UserInfoModel]? = nil
    private let userInfoRepository = UserInfoRepositoryImpl()
    private let likeRepository = LikeRepositoryImpl()
    private let translator = BrowseTranslator()
    
    func read(closure: @escaping ([UserInfoModel]?, Bool)-> Void) {
        userInfoRepository.findAll { (entitys, isSuccess) in
            if isSuccess {
                self.data = self.translator.translate(entitys)
                closure(self.data, isSuccess)
            } else {
                closure(nil, isSuccess)
            }
        }
    }
    
    func liked(_ model: UserInfoModel) {
        //likeRepository.save
        likeRepository.save(by: DataManager.shared.currentuserInfo?.objectId ?? "", likedAt: model.objectId, closure: nil)
    }
    
    func disliked(_ model: UserInfoModel) {
        likeRepository.save(by: DataManager.shared.currentuserInfo?.objectId ?? "", dislikedAt: model.objectId, closure: nil)
    }
    
}
