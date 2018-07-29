//
//  LoginModel.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/29.
//

import UIKit
import RxSwift
import RxCocoa

class LoginModel: BaseModel {

    var username = BehaviorRelay<String>(value: "")
    var password = BehaviorRelay<String>(value: "")
    var confirmPassword = BehaviorRelay<String>(value: "")


}
