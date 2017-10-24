//
//  Follow+CoreDataProperties.swift
//  
//
//  Created by ひかりちゃん on 2017/10/23.
//
//

import Foundation
import CoreData


extension Follow {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Follow> {
        return NSFetchRequest<Follow>(entityName: "Follow")
    }

    @NSManaged public var updateAt: Date?
    @NSManaged public var followingId: String?
    @NSManaged public var objectId: String?
    @NSManaged public var userId: String?

}
