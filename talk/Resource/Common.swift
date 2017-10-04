//
//  Common.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/10.
//
//

import UIKit

class Common: NSObject {

    class func dateToString(date: Date, format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    class func stringToDate(dateString: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
    
}
