//
//  UserInfoApi.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/31.
//

import UIKit
import Parse

enum GetUserInfoType: Int {
    case Following
    case Follower
    
    var column: String {
        if self == .Following {
            return "userId"
        } else if self == .Follower {
            return "followingUserId"
        }
        return ""
    }
}

class UserInfoApi: NSObject {
    typealias UserInfoCompletionHandler = (Response<UserInfo>) -> Void
    typealias UserInfoListCompletionHandler = (Response<[UserInfo]>) -> Void
    
    class func findUserInfo(with type: GetUserInfoType, completion: @escaping UserInfoListCompletionHandler) {
        
        let followQuery = PFQuery(className: "Follow")
        followQuery.whereKey(type.column, equalTo: DataManager.shared.currentUserObjectId)
        followQuery.findObjectsInBackground { (objects, error) in
            var objectIds = [String]()
            if let guardObjects = objects {
                for info in guardObjects {
                    objectIds.append(info.objectId ?? "")
                }
            }
            
            let query = PFQuery(className: "UserInfo")
            query.whereKey("userId", containedIn: objectIds)
            query.findObjectsInBackground(block: { (objects, error) in
                let response = Response<[UserInfo]>()
                response.data = UserInfo.convertUserInfos(with: objects)
                response.status = .success
                
                completion(response)
            })
        }
    }
    
    class func findUserInfo(with userId: String, completion: @escaping UserInfoCompletionHandler) {
        let query = PFQuery(className: "UserInfo")
        query.whereKey("userId", equalTo: userId)
        query.findObjectsInBackground(block: { (objects, error) in
            if let infos = UserInfo.convertUserInfos(with: objects) ,
                let currentUserInfo = infos.first {
                let response = Response<UserInfo>()
                response.data = currentUserInfo
                response.status = .success
                completion(response)
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
        pfObject["userId"] = userInfo.userId
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
