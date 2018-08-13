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
    private let browseTranslator = BrowseTranslator()

    var isSelf: Bool = true
        
    func upload(album: UIImage, closure: @escaping (Bool)-> Void) {
        infoRepository.upload(image: album) { (isSuccess) in
            closure(isSuccess)
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
