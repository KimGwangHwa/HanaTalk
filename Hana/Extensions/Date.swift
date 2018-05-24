//
//  Date.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import Foundation

extension Date {
    
    func string(format: DateTemplate) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
