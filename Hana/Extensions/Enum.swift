//
//  Enum.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import Foundation


enum DateTemplate: String {
    case date = "yMd"     // 2017/1/1
    case time = "Hms"     // 12:39:22
    case full = "yMdkHms" // 2017/1/1 12:39:22
    case onlyHour = "k"   // 17
    case weekDay = "EEEE"
}


enum Sex: Int {
    case unknown
    case male
    case female
    
    var toString: String {
        switch self {
        case .unknown:
            return "unknown"
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
}

enum InputType: Int {
    case email
    case text       // 100
    case longText   // 255
    case phone
}


