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
    @NSManaged var sex: Bool
    @NSManaged var user: PFUser?
    @NSManaged var location: PFGeoPoint?
    @NSManaged var bio: String?
    @NSManaged var keyword: String?
    @NSManaged var profileUrl: String?
    @NSManaged var album: [String]?

    class func getCurrentUserInfo() -> UserInfo? {
        let query = PFQuery(className: UserInfoClassName)
        query.whereKey(UserColumnName, equalTo: PFObject(withoutDataWithClassName: UserClassName, objectId: PFUser.current()?.objectId))
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
    
    class func findAll(completion: @escaping ([UserInfo]?, Bool) -> Void) {
        let query = PFQuery(className: UserInfoClassName)
        
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let guardObjects = objects as? [UserInfo] {
                    completion(guardObjects, true)
                } else {
                    completion(nil, false)
                }
            }
        }
    }
    
    class func findUserInfo(byObjectId: String?, userObjectId: String?, nickName: String?, completion: @escaping (UserInfo?, Bool) -> Void) {
        let query = PFQuery(className: UserInfoClassName)
        if let guardObjectid = userObjectId {
            query.whereKey(UserColumnName, equalTo: PFObject(withoutDataWithClassName: UserClassName, objectId: guardObjectid))
        }
        if let guardObjectid = byObjectId {
            query.whereKey(ObjectIdColumnName, equalTo: guardObjectid)
        }
        if let guardNickName = nickName {
            query.whereKey(NicknameColumnName, equalTo: guardNickName)
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
