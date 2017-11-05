//
//  UserInfo+CoreDataClass.swift
//  
//
//  Created by ひかりちゃん on 2017/10/24.
//
//

import Foundation
import CoreData
import Parse

@objc(UserInfo)
public class UserInfo: NSManagedObject {
    
    class func createNewRecord() -> UserInfo {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.UserInfo.rawValue, in: CoreDataHelper.shared.managedObjectContext)
        let userInfo = UserInfo(entity: tweet!, insertInto: CoreDataHelper.shared.managedObjectContext)
        return userInfo
    }
    
    class func convertUserInfos(with ojbects: [PFObject]?) -> [UserInfo]? {
        
        if let guardObject = ojbects {
            var retInfos = [UserInfo]()
            for item in guardObject {
                let object: UserInfo = UserInfo.createNewRecord()
                object.objectId = item.objectId ?? ""
                object.birthday = item["birthday"] as? Date
                object.statusMessage =  item["statusMessage"] as? String
                object.email =  item["email"] as? String
                object.profilePictureUrl =  (item["profilePicture"] as? PFFile)?.url
                object.nickName =  item["nickName"] as? String
                object.userId =  (item["userId"] as? String) ?? ""
                object.postsCount = (item["postsCount"] as? Int16) ?? 0
                object.followingCount = (item["followingCount"] as? Int16) ?? 0
                object.followersCount = (item["followersCount"] as? Int16) ?? 0
                retInfos.append(object)
            }
            return retInfos
        }
        return nil
    }
}
