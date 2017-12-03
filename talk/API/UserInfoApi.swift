//
//  UserInfoApi.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/31.
//

import UIKit
import Parse

enum GetUserInfoType: Int {
    case following
    case follower
    
    var column: String {
        if self == .following {
            return "userInfo"
        } else if self == .follower {
            return "followingUserInfo"
        }
        return ""
    }
}

class UserInfoApi: NSObject {
    typealias UserInfoCompletionHandler = (Response<UserInfo>) -> Void
    typealias UserInfoListCompletionHandler = (Response<[UserInfo]>) -> Void
    
    class func findUserInfo(with type: GetUserInfoType, completion: @escaping UserInfoListCompletionHandler) {
        
        let followQuery = PFQuery(className: "Follow")
        guard let currentUser = DataManager.shared.currentUser,
              let currentUserObjectId = currentUser.objectId else {
            return
        }
        followQuery.includeKey(GetUserInfoType.follower.column)
        followQuery.includeKey(GetUserInfoType.following.column)
        followQuery.whereKey(type.column, equalTo: PFObject(withoutDataWithClassName: "UserInfo", objectId: currentUserObjectId))
        followQuery.findObjectsInBackground { (objects, error) in
            var retObjects: [UserInfo]?
            if let guardObjects = objects {
                retObjects = [UserInfo]()
                for object in guardObjects {
                    if let pfUserInfo = object[type.column] as? PFObject {
                        if let userInfo = UserInfo.convertUserInfo(with: pfUserInfo) {
                            retObjects?.append(userInfo)
                        }
                    }
                }
            }
            let response = Response<[UserInfo]>()
            response.data = retObjects
            response.status = error != nil ? .failure : .success
            completion(response)

        }
    }
    
    class func findUserInfo(with userId: String, completion: @escaping UserInfoCompletionHandler) {
        
        let query = PFQuery(className: "UserInfo")
        query.whereKey("user", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: userId))
        query.findObjectsInBackground(block: { (objects, error) in
            if let guardObjects = objects {
                for object in guardObjects {
                    let response = Response<UserInfo>()
                    response.data = UserInfo.convertUserInfo(with: object)
                    response.status = error != nil ? .failure : .success
                    completion(response)
                }
            }
        })
    }
    
    class func saveUserInfo(userInfo: UserInfo, completion: @escaping StatusCompletionHandler) {
        let pfObject = PFObject(className: "UserInfo")
        pfObject["nickName"] = userInfo.nickName ?? ""
        pfObject["email"] = userInfo.email ?? ""
        pfObject["phoneNumber"] = userInfo.phoneNumber ?? ""
        pfObject["statusMessage"] = userInfo.statusMessage ?? ""
        pfObject["birthday"] = userInfo.birthday ?? Date()
        pfObject["user"] = PFUser.current()
        pfObject["sex"] = userInfo.sex
        pfObject.saveInBackground { (isSuccess, error) in
            completion(isSuccess == true ? .success: .failure )
        }
    }
    func saveProfile(imageData:Data, completion: @escaping StatusCompletionHandler) {
        let pfObject = PFObject(className: "UserInfo")
        pfObject["profilePicture"] = PFFile(data: imageData)
        pfObject.saveInBackground { (isSuccess, error) in
            completion(isSuccess == true ? .success: .failure )
        }
    }
    
}
