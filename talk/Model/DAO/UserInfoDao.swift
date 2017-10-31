//
//  UserInfoDao.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/24.
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

class UserInfoDao: NSObject {
    
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
                response.status = .Success
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
                response.status = .Success
                completion(response)
            }
        })
    }

    class func findFirst() -> UserInfo? {
        let fetchRequest = UserInfo.fetchUserInfoRequest()
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData.last
        } catch {
            return nil;
        }
    }
    
    class func findBy(userId: String) -> UserInfo? {
        let fetchRequest = UserInfo.fetchUserInfoRequest()
        let predicate = NSPredicate(format: "userId = %@", userId)
        fetchRequest.predicate = predicate
        do {
            let fetchData = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            return fetchData.last
        } catch {
            return nil;
        }
    }


}
