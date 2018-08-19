//
//  UserInfoUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/26.
//

import UIKit
import RxSwift

class UserInfoUseCase: NSObject {

    var objectId: String?
    var model: UserInfoModel!
    var editModel: EditUserInfoModel!
    
    var isSelf: Bool = true
    
    private let editTranslator = EditUserInfoTranslator()
    private let infoRepository = UserInfoRepositoryImpl()
    private let browseTranslator = BrowseTranslator()
    private let disposeBag = DisposeBag()
    
    func upload(album: UIImage, closure: @escaping (Bool)-> Void) {
        infoRepository.upload(image: album) { (url, isSuccess) in
            closure(isSuccess)
        }
    }
    
    func read(closure: @escaping (Bool)-> Void) {
        if objectId == nil {
            let entity = UserInfoRepositoryImpl.current()
            model = browseTranslator.translate(entity)
            editModel = editTranslator.translate(entity)
            closure(true)
        } else {
            infoRepository.find(by: objectId!) { (entity, isSuccess) in
                self.model = self.browseTranslator.translate(entity)
                self.editModel = self.editTranslator.translate(entity)
                closure(isSuccess)
            }
        }
    }
    
    func valueChanged(closure: @escaping (Bool)-> Void) {
        editModel.sex.asObservable().subscribe { (event) in
            let isEmpty = self.editModel.sex.value.isEmpty || self.editModel.nickname.value.isEmpty || self.editModel.mail.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
        
        editModel.nickname.asObservable().subscribe { (event) in
            let isEmpty = self.editModel.sex.value.isEmpty || self.editModel.nickname.value.isEmpty || self.editModel.mail.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
        
        editModel.mail.asObservable().subscribe { (event) in
            let isEmpty = self.editModel.sex.value.isEmpty || self.editModel.nickname.value.isEmpty || self.editModel.mail.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
    }
    
    func uploadEdited(closure: @escaping (Bool)-> Void) {
        let entity = editTranslator.reverseTranslate(editModel)
        infoRepository.upload(image: editModel.profileImage.value!) { (url, isSuccess) in
            entity?.profileUrl = url
            self.infoRepository.save(by: entity!, closure: { (isSuccess) in
                closure(isSuccess)
            })
        }
    }
    
}
