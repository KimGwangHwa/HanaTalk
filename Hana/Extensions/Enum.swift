//
//  Enum.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import Foundation


enum DateTemplate: String {
    case full = "y/M/d/ k:H:m:s"
    case date = "y/M/d"
    case time = "H:m"
    case dateAndTime = "y/M/d H:m"
    case year = "yyyy"
    case month = "M"
    case week = "EEEE"
    case day = "d"  
    case hour = "H"
}


enum Sex: Int {
    case unknown
    case male
    case female
    
    var name: String {
        switch self {
        case .unknown:
            return "unknown"
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
    
    
    init(name: String) {
        if name == Sex.unknown.name {
            self =  Sex.unknown
        } else if name == Sex.male.name {
            self =  Sex.male
        } else if name == Sex.female.name {
            self =  Sex.female
        } else {
            self = Sex.unknown
        }
    }
    
    static var names: [String] {
        return [Sex.female.name, Sex.male.name, Sex.unknown.name]
    }
    
}

enum UserInfoType: Int {
    case nickname
    case birthDay
    case sex
    case bio
    
    case email
    case phoneNumber
    
    var name: String {
        
        switch self {
        case .nickname:
            return "nickname"
        case .birthDay:
            return "birthDay"
        case .sex:
            return "sex"
        case .bio:
            return "bio"
        case .email:
            return "email"
        case .phoneNumber:
            return "phoneNumber"
        }
    }
    
    static let count = 6
}




