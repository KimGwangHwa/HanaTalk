//
//  UserInfoUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/26.
//

import UIKit

class UserInfoUseCase: NSObject {

    var model: UserInfoModel!
   
    var editModel: UserInfoModel? {
        
        let currentUserInfo = UserInfoRepositoryImpl.current()
        return browseTranslator.translate(currentUserInfo)
    }
    
    private let infoRepository = UserInfoRepositoryImpl()
    private let imageRepository = ImageUploadRepositoryImpl()
    private let browseTranslator = BrowseTranslator()

    var isSelf: Bool {
        if model == nil {
            return true
        }
        return false
    }
        
    func upload(album: UIImage, closure: @escaping (Bool)-> Void) {
        imageRepository.upload(image: album) { (url, isSuccess) in
            self.model.imageUrls.append(url!)
            if let entity = self.browseTranslator.reverseTranslate(self.model) {
                self.infoRepository.save(by: entity, closure: { (isSuccess) in
                    closure(isSuccess)
                })
            }
        }
    }
    
    func read(closure: @escaping (Bool)-> Void) {
        if model == nil {
            infoRepository.findCurrent { (entity, isSuccess) in
                self.model = self.browseTranslator.translate(entity)
                closure(isSuccess)
            }
        } else {
            infoRepository.find(by: model.objectId ?? "") { (entity, isSuccess) in
                self.model = self.browseTranslator.translate(entity)
                closure(isSuccess)
            }
        }
    }
}
