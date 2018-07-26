//
//  BrowseModel.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class UserInfoModel: BaseModel {
    var name: String!
    var age: Int!
    var imageUrls: [String]!
    var profileUrl: String!
    
    // detail
    var subName: String?
    var bio: String?
    var sex: Sex = .unknown
        
    var birthDay: String?
    var email: String?
    var tel: String?
    
}
