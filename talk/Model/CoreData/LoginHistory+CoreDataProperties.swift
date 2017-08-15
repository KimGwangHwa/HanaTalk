//
//  LoginHistory+CoreDataProperties.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/09.
//
//

import Foundation
import CoreData


extension LoginHistory {

    @nonobjc public class func fetchLoginHistoryRequest() -> NSFetchRequest<LoginHistory> {
        return NSFetchRequest<LoginHistory>(entityName: "LoginHistory")
    }

    @NSManaged public var userId: String?
    @NSManaged public var password: String?
    @NSManaged public var updateDate: NSDate?
    
}
