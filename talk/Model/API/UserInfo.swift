//
//  UserInfo.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class UserInfo: NSObject {
    public var birthday: Date?
    public var createAt: Date?
    public var email: String?
    public var followersCount: Int = 0
    public var followingCount: Int = 0
    public var latitude: Double = 0.0
    public var longitude: Double = 0.0
    public var nickName: String?
    public var objectId: String?
    public var phoneNumber: String?
    public var postsCount: Int = 0
    public var profileImage: String?
    public var sex: Bool = false
    public var statusMessage: String?
    public var updateAt: Date?
    public var user: User?
    
    class func convertUserInfo(with ojbect: PFObject?) -> UserInfo? {
        
        if let guardObject = ojbect {
            let retObject: UserInfo = UserInfo()
            retObject.objectId = guardObject.objectId
            retObject.birthday = guardObject["birthday"] as? Date
            retObject.statusMessage =  guardObject["statusMessage"] as? String
            retObject.email =  guardObject["email"] as? String
            retObject.profileImage = guardObject["profileImageUrl"] as? String
            retObject.nickName =  guardObject["nickName"] as? String
            if let guardUser = User.convertUser(with: guardObject["user"] as? PFObject) {
                retObject.user = guardUser
            }
            retObject.postsCount = (guardObject["postsCount"] as? Int) ?? 0
            retObject.followingCount = (guardObject["followingCount"] as? Int) ?? 0
            retObject.followersCount = (guardObject["followersCount"] as? Int) ?? 0
        }
        return nil
    }
}
