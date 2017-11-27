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
        guard let currentUser = DataManager.shared.currentUser else {
            return
        }
        
        followQuery.whereKey(type.column, equalTo: currentUser.objectId)
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
        
//        let a = PFObject(className: "UserInfo")
//        let image = R.image.flower_png8() ?? UIImage()
//        let data = UIImagePNGRepresentation(image) ?? Data()
//        var list = [PFFile]()
//        guard let p = PFFile(data: data) else {
//            return
//        }
//        list.append(p)
//        a["test"] = list
//
//        a.saveInBackground()
//        return
        
        let query = PFQuery(className: "UserInfo")
        query.whereKey("userId", equalTo: "uSMpMUKXr8")
        query.findObjectsInBackground(block: { (objects, error) in
            if let guardObj = objects {
                if let guard2 = guardObj.first {
                    if let b = guard2["test"] as? [PFFile] {
                        print(b.first?.url)
                    }
                    
                }
                
            }
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
//        pfObject["userId"] = userInfo.userId
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
