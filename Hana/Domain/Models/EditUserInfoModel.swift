//
//  EditUserInfoModel.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/31.
//

import UIKit
import RxCocoa
import RxSwift

class EditUserInfoModel: NSObject {
    
    var profileUrl = BehaviorRelay<String>(value: "")
    var nickname = BehaviorRelay<String>(value: "")
    var birthDay = BehaviorRelay<String>(value: "")
    var mail = BehaviorRelay<String>(value: "")
    var tel = BehaviorRelay<String>(value: "")
    var sex = BehaviorRelay<String>(value: "")
    var bio = BehaviorRelay<String>(value: "")
    
    var configured: Bool = false
    
}
