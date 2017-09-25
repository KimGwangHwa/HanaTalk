//
//  UserInfo.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/23.
//
//

import UIKit
import Parse

class UserInfo: PFObject {

    //var objectId = ""
    
    var statusMessage: String?
    
    var userId = ""
    
    var email: String?
    
    var phoneNumber: String?
    
    var sex: Bool = true
    
    var profilePicture: String? //URL
    
    var nickName: String?
    
    var latitude: CGFloat = 0.0

    var longitude: CGFloat = 0.0
    
    var followingCount: Int?
    
    var followedCount: Int?
    
    class func creatUserInfos(with ojbects: [PFObject]?) -> [UserInfo]? {

        if let guardObject = ojbects {
            var retInfos = [UserInfo]()

            for item in guardObject {
                let object = UserInfo()

                object.statusMessage =  item["statusMessage"] as? String
                object.email =  item["email"] as? String
                object.profilePicture =  (item["statusMessage"] as? PFFile)?.url
                object.nickName =  item["nickName"] as? String
                object.userId =  item["userId"] as! String
                
                retInfos.append(object)
                
            }
            return retInfos

        }

        return nil
    }

    
    
}
