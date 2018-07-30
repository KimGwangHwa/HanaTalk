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
        let organizer = UserInfoDao.current()?.objectId ?? ""
        let likedObjectId = model.objectId ?? ""
        
        likeRepository.liked(with: likedObjectId) { (entity, isSuccess) in
            // PUSH
            self.likeRepository.matched(of: organizer, reciver: likedObjectId, closure: { (isMatched, isSuccess) in
                
            })
            NotificationManager.shared.sendPush(with: [organizer, likedObjectId], objectId: entity?.objectId ?? "", alert: "", type: .like)
        }
    }
    
    func disliked(_ model: UserInfoModel) {
        let objectId = model.objectId ?? ""
        likeRepository.disliked(with: objectId, closure: nil)
    }
    
}
