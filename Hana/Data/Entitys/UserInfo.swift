//
//  UserInfo.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class UserInfo: PFObject, PFSubclassing {
    static func parseClassName() -> String {
        return UserInfoClassName
    }

    @NSManaged var birthday: Date?
    @NSManaged var email: String?
    @NSManaged var nickname: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var user: PFUser?
    @NSManaged var location: PFGeoPoint?
    @NSManaged var bio: String?
    @NSManaged var keyword: String?
    @NSManaged var profileUrl: String?
    @NSManaged var albums: [String]?
    @NSManaged var todayWantCategory: CategoryEntity?
    @NSManaged var todayWantEnd: Date?

    public var sex: Sex {
        get{
            if let s = self["sex"] as? Int {
                return Sex(rawValue: s) ?? .unknown
            }
            return .unknown
        }
        set{
            self["sex"] = newValue.rawValue
        }
    }
    @NSManaged var configured: Bool


}
