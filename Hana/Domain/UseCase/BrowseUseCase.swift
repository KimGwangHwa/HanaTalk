//
//  BrowseUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class BrowseUseCase: NSObject {
    var data = [UserInfoModel]()
    private let userInfoRepository = UserInfoRepositoryImpl()
    private let likeRepository = LikeRepositoryImpl()
    private let translator = BrowseTranslator()
    
    var currentProfileUrl: String? {
        return UserInfoDao.current()?.profileUrl
    }
    
    func read(closure: @escaping ([UserInfoModel]?, Bool)-> Void) {
        data.removeAll()
        userInfoRepository.findAll { (entitys, isSuccess) in
            if isSuccess {
                if let models = self.translator.translate(entitys) {
                    self.data.append(contentsOf: models)
                }
                closure(self.data, isSuccess)
            } else {
                closure(nil, isSuccess)
            }
        }
    }
    
    func liked(_ model: UserInfoModel, closure: @escaping (Bool)-> Void) {
        let organizer = UserInfoDao.current()?.objectId ?? ""
        let likedObjectId = model.objectId ?? ""
        
        likeRepository.liked(with: likedObjectId) { (entity, isSuccess) in
            let isMatched = entity?.matched.contains(where: { $0.objectId == model.objectId }) ?? false
            let type: PushNotificationType = isMatched ? .matched : .like
            let alertMessage = R.string.localizable.push_Like_Title(model.name)
            NotificationManager.shared.sendPush(with: [organizer, likedObjectId], objectId: likedObjectId, alert: alertMessage, type: type)
            closure(isMatched)
        }
    }
    
    func disliked(_ model: UserInfoModel) {
        let objectId = model.objectId ?? ""
        likeRepository.disliked(with: objectId, closure: nil)
    }
    
}
