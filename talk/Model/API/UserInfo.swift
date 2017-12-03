//
//  UserInfo.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit

class UserInfo: NSObject {
    public var birthday: Date?
    public var createAt: Date?
    public var email: String?
    public var followersCount: Int16
    public var followingCount: Int16
    public var latitude: Double
    public var longitude: Double
    public var nickName: String?
    public var objectId: String?
    public var phoneNumber: String?
    public var postsCount: Int16
    public var profileImage: String?
    public var sex: Bool
    public var statusMessage: String?
    public var updateAt: Date?
    public var user: User?
}
