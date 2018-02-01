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
        return "UserInfo"
    }
    
    @NSManaged  var birthday: Date?
    @NSManaged  var createAt: Date?
    @NSManaged  var email: String?
    @NSManaged  var followersCount: Int
    @NSManaged  var followingCount: Int
    @NSManaged  var latitude: Double
    @NSManaged  var longitude: Double
    @NSManaged  var nickName: String?
    @NSManaged  var phoneNumber: String?
    @NSManaged  var postsCount: Int
    @NSManaged  var profileImage: String?
    @NSManaged  var sex: Bool
    @NSManaged  var statusMessage: String?
    @NSManaged  var updateAt: Date?
    @NSManaged  var user: PFUser?

    
    class func getCurrentUserInfo() -> UserInfo? {
        let query = PFQuery(className: "UserInfo")
        query.whereKey("user", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: PFUser.current()?.objectId))
        query.fromLocalDatastore()
        do {
            let pfObject = try query.getFirstObject() as? UserInfo
            return pfObject
        } catch {
            return nil
        }
    }
    
    class func findUserInfo(byObjectId: String?, completion: @escaping (UserInfo?, Bool) -> Void) {
        findUserInfo(byObjectId: byObjectId, userObjectId: nil, nickName: nil, completion: completion)
    }
    
    class func findUserInfo(byUserObjectId: String?, completion: @escaping (UserInfo?, Bool) -> Void) {
        findUserInfo(byObjectId: nil, userObjectId: byUserObjectId, nickName: nil, completion: completion)
    }
    class func findUserInfo(byNickName: String?, completion: @escaping (UserInfo?, Bool) -> Void) {
        findUserInfo(byObjectId: nil, userObjectId: nil, nickName: byNickName, completion: completion)
    }
    
    class func findUserInfo(byObjectId: String?, userObjectId: String?, nickName: String?, completion: @escaping (UserInfo?, Bool) -> Void) {
        let query = PFQuery(className: "UserInfo")
        if let guardObjectid = userObjectId {
            query.whereKey("user", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: guardObjectid))
        }
        if let guardObjectid = byObjectId {
            query.whereKey("objectId", equalTo: guardObjectid)
        }
        if let guardNickName = nickName {
            query.whereKey("nickName", equalTo: guardNickName)
        }
        
        query.findObjectsInBackground { (objects, error) in
            if let guardObject = objects?.first as? UserInfo {
                completion(guardObject, true)
            } else {
                completion(nil, false)
            }
        }
    }
}
