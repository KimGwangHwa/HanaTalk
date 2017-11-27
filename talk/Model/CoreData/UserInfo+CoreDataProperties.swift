//
//  UserInfo+CoreDataProperties.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/27.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var createAt: Date?
    @NSManaged public var email: String?
    @NSManaged public var followersCount: Int16
    @NSManaged public var followingCount: Int16
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var nickName: String?
    @NSManaged public var objectId: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var postsCount: Int16
    @NSManaged public var profileImageUrl: String?
    @NSManaged public var sex: Bool
    @NSManaged public var statusMessage: String?
    @NSManaged public var updateAt: Date?
    @NSManaged public var user: User

}
