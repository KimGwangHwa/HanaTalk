//
//  User+CoreDataProperties.swift
//  
//
//  Created by ひかりちゃん on 2017/10/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var objectId: String?
    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var updateAt: Date?

}
