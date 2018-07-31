//
//  EditUserInfoUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/31.
//

import UIKit

class EditUserInfoUseCase: NSObject {
    var model: EditUserInfoModel!
    
    private let translator = EditUserInfoTranslator()
    private let imageRepositoryImpl = ImageUploadRepositoryImpl()
    private let infoRepositoryImpl = UserInfoRepositoryImpl()

    override init() {
        let currentUserInfo = UserInfoRepositoryImpl.current()
        model = translator.translate(currentUserInfo)!
    }
    
    func upload(album: UIImage, closure: @escaping (Bool)-> Void) {
        imageRepositoryImpl.upload(image: album) { (url, isSuccess) in
            guard let entity = self.translator.reverseTranslate(self.model) else {
                return
            }
            self.infoRepositoryImpl.save(by: entity, closure: { (isSuccess) in
                closure(isSuccess)
            })
        }
    }
    
    
}
