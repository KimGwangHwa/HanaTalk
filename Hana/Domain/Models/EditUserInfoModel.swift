//
//  EditUserInfoModel.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/31.
//

import UIKit
import RxCocoa
import RxSwift

class EditUserInfoModel: BaseModel {
    
    var profileUrl: String!
    var nickname = BehaviorRelay<String>(value: "")
    var birthDay = BehaviorRelay<String>(value: "")
    var mail = BehaviorRelay<String>(value: "")
    var tel = BehaviorRelay<String>(value: "")
    var sex = BehaviorRelay<String>(value: "")
    var bio = BehaviorRelay<String>(value: "")
    var profileImage = BehaviorRelay<UIImage?>(value: #imageLiteral(resourceName: "placeholderImage"))

    var configured: Bool = false
    
}
