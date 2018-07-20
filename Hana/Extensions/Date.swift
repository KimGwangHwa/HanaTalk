//
//  Date.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import Foundation

extension Date {
    
    func string(format: DateTemplate) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    var weekDay: Int {
        let cal = NSCalendar.current
        return cal.component(.weekday, from: self)
    }
    
    var age: Int {
        let timezone = TimeZone.current
        let localDate = Date(timeIntervalSinceNow: Double(timezone.secondsFromGMT()))
        
        let localDateStrnig = localDate.string(format: .year) + localDate.string(format: .month) + localDate.string(format: .day)
        let birthDayStrnig = self.string(format: .year) + self.string(format: .month) + self.string(format: .day)

        let localDateIntVal = Int(localDateStrnig)
        let birthDateIntVal = Int(birthDayStrnig)
        
        let age = (localDateIntVal! - birthDateIntVal!) / 1000
        return age
    }
}
