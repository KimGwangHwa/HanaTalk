//
//  UserInfoApi.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/31.
//

import UIKit
import Parse

class UserInfoApi: NSObject {
    typealias UserInfoCompletionHandler = (Response<UserInfo>) -> Void
    
    class func findCurrentUserInfo(by userObjectId: String?, completion: @escaping UserInfoCompletionHandler) {
        let query = PFQuery(className: "UserInfo")
        if let guardObjectid = userObjectId {
            query.whereKey("user", equalTo: PFObject(withoutDataWithClassName: "_User", objectId: guardObjectid))
        }
        
        query.findObjectsInBackground { (objects, error) in
            if let guardObject = objects?.first {
                let response = Response<UserInfo>()
                response.data = UserInfo.convertUserInfo(with: guardObject)
                response.status = error != nil ? .failure : .success
                guardObject.pinInBackground()
                completion(response)
            }
        }
    }
    
    class func findUserInfo(by objectId: String?, completion: @escaping UserInfoCompletionHandler) {
        let query = PFQuery(className: "UserInfo")
        if let guradObjectId = objectId {
            query.whereKey("objectId", equalTo: guradObjectId)
        }
        query.findObjectsInBackground { (objects, error) in
            if let guardObject = objects?.first {
                let response = Response<UserInfo>()
                response.data = UserInfo.convertUserInfo(with: guardObject)
                response.status = error != nil ? .failure : .success
                completion(response)
            }
        }
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
            pfObject.pinInBackground()
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
