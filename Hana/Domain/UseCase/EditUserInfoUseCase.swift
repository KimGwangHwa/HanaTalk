//
//  EditUserInfoUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/31.
//

import UIKit
import RxSwift

class EditUserInfoUseCase: NSObject {
    var model: EditUserInfoModel!
    let disposeBag = DisposeBag()

    private let translator = EditUserInfoTranslator()
    private let infoRepositoryImpl = UserInfoRepositoryImpl()

    override init() {
        let currentUserInfo = UserInfoRepositoryImpl.current()
        model = translator.translate(currentUserInfo)!
    }
    
    func valueChanged(closure: @escaping (Bool)-> Void) {
        model.sex.asObservable().subscribe { (event) in
            
            let isEmpty = self.model.sex.value.isEmpty || self.model.nickname.value.isEmpty || self.model.mail.value.isEmpty
            closure(isEmpty)
        }.disposed(by: disposeBag)
        
        model.nickname.asObservable().subscribe { (event) in
            let isEmpty = self.model.sex.value.isEmpty || self.model.nickname.value.isEmpty || self.model.mail.value.isEmpty
            closure(isEmpty)
        }.disposed(by: disposeBag)
        
        model.mail.asObservable().subscribe { (event) in
            let isEmpty = self.model.sex.value.isEmpty || self.model.nickname.value.isEmpty || self.model.mail.value.isEmpty
            closure(isEmpty)
        }.disposed(by: disposeBag)
    }
    
    func update(closure: @escaping (Bool)-> Void) {
        infoRepositoryImpl.upload(image: model.profileImage.value!) { (isSuccess) in
            closure(isSuccess)
        }
    }
    
    
}
