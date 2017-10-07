//
//  Common.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/10.
//
//

import UIKit

class Common: NSObject {

    class func dateToString(date: Date?, format: String) -> String? {
        
        if let guradDate = date  {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: guradDate)
        }
        return nil
    }
    
    class func stringToDate(dateString: String?, format: String) -> Date? {
        if let guradDateString = dateString {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.date(from: guradDateString)
        }
        return nil
    }
    
}
