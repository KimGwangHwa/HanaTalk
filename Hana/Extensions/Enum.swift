//
//  Enum.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import Foundation
import UIKit

enum DateTemplate: String {
    case full = "y/M/d/ EEEE k:H:m"
    case date = "y/M/d"
    case time = "H:mm"
    case dateAndTime = "y/M/d H:mm"
    case year = "yyyy"
    case month = "M"
    case week = "EEEE"
    case day = "d"  
    case hour = "H"
}

enum Week: Int {
    case sunDay = 0
    case monDay
    case tuesDay
    case wednesDay
    case thursDay
    case friDay
    case saturDay
    
    var color: UIColor {
        switch self {
        case .monDay:
            return UIColor.hex("f7f9ff")
        case .tuesDay:
            return UIColor.hex("ff6767")
        case .wednesDay:
            return UIColor.hex("4bbb8b")
        case .thursDay:
            return UIColor.hex("fff9af")
        case .friDay:
            return UIColor.hex("f73859")
        case .saturDay:
            return UIColor.hex("283149")
        case .sunDay:
            return UIColor.hex("ff6600")
        }
    }
    
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




