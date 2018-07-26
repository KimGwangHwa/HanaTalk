//
//  UserInfoUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/26.
//

import UIKit

class UserInfoUseCase: NSObject {

    var model: UserInfoModel!
    
    private let infoRepository = UserInfoRepositoryImpl()
    private let imageRepository = ImageUploadRepositoryImpl()
    private let browseTranslator = BrowseTranslator()

    var isSelf: Bool {
        if model.objectId == DataManager.shared.currentuserInfo?.objectId {
            return true
        }
        return false
    }
    
    override init() {
        if model == nil {
            model = browseTranslator.translate(DataManager.shared.currentuserInfo)
        }
    }
    
    func upload(album: UIImage, closure: @escaping (Bool)-> Void) {
        imageRepository.upload(image: album) { (url, isSuccess) in
            if let entity = self.browseTranslator.reverseTranslate(self.model) {
                self.infoRepository.save(by: entity, closure: { (isSuccess) in
                    closure(isSuccess)
                })
            }
        }
    }
    
    func read(closure: @escaping (Bool)-> Void) {
        infoRepository.find(by: model.objectId) { (entity, isSuccess) in
            self.model = self.browseTranslator.translate(entity)
        }
    }

}
