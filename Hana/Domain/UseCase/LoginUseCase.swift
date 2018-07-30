//
//  LoginUseCase.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/29.
//

import UIKit
import RxSwift

class LoginUseCase: NSObject {
    
    var model = LoginModel()
    let disposeBag = DisposeBag()
    private let infoRepository = UserInfoRepositoryImpl()
    
    func signinValueChanged(closure: @escaping (Bool)-> Void) {
        model.username.asObservable().subscribe { (username) in
            let isEmpty = self.model.username.value.isEmpty ||  self.model.password.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
        
        model.password.asObservable().subscribe { (username) in
            let isEmpty = self.model.username.value.isEmpty ||  self.model.password.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
    }
    
    func signupValueChanged(closure: @escaping (Bool)-> Void) {
        model.username.asObservable().subscribe { (_) in
            let isEmpty = self.model.username.value.isEmpty ||  self.model.password.value.isEmpty || self.model.confirmPassword.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
        
        model.password.asObservable().subscribe { (_) in
            let isEmpty = self.model.username.value.isEmpty ||  self.model.password.value.isEmpty || self.model.confirmPassword.value.isEmpty
            closure(isEmpty)
            }.disposed(by: disposeBag)
        
        model.confirmPassword.asObservable().subscribe { (_) in
            let isEmpty = self.model.username.value.isEmpty ||  self.model.password.value.isEmpty || self.model.confirmPassword.value.isEmpty
            closure(isEmpty)
        }.disposed(by: disposeBag)
    }
    
    func existenceUsername(closure: @escaping (Bool)-> Void) {
        infoRepository.existence(username: model.username.value, closure: closure)
    }
    
    func signin(closure: @escaping (Bool)-> Void) {
        infoRepository.signin(username: model.username.value, password: model.password.value, closure: closure)
    }
    
    func signup(closure: @escaping (Bool)-> Void) {
        infoRepository.signup(username: model.username.value, password: model.password.value, closure: closure)
    }
}
