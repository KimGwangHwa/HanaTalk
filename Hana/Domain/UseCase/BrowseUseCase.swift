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
    
    var currentProfileUrl: String? {
        return UserInfoDao.current()?.profileUrl
    }
    
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
    
    func liked(_ model: UserInfoModel, closure: @escaping (Bool)-> Void) {
        let organizer = UserInfoDao.current()?.objectId ?? ""
        let likedObjectId = model.objectId ?? ""
        
        likeRepository.liked(with: likedObjectId) { (isMatched, isSuccess) in
            if !isMatched {
                let alertMessage = R.string.localizable.push_Like_Title(model.name)
                NotificationManager.shared.sendPush(with: [organizer, likedObjectId], objectId: likedObjectId, alert: alertMessage, type: .like)
            }
            closure(isMatched)
        }
    }
    
    func disliked(_ model: UserInfoModel) {
        let objectId = model.objectId ?? ""
        likeRepository.disliked(with: objectId, closure: nil)
    }
    
}
