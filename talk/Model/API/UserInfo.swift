//
//  UserInfo.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/23.
//
//

import UIKit
import Parse

class UserInfo: PFObject, PFSubclassing {
    
    /**
     The name of the class as seen in the REST API.
     */
    static func parseClassName() -> String {
        return "UserInfo"
    }


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
    
    var followersCount: Int?
    
    var postsCount: Int?
    
    class func upload(imageFile: UIImage) {
        let data = imageFile.sd_imageData()
        
        let pffile = PFFile(name: "test.png", data: data!)
        let info = UserInfo()
        info["profilePicture"] = pffile
        info.objectId = DataManager.shared.currentUserInfo?.objectId
        info.saveInBackground { (isSuccess, error) in
            
        }
        
    }
    
    class func creatUserInfos(with ojbects: [PFObject]?) -> [UserInfo]? {

        if let guardObject = ojbects {
            var retInfos = [UserInfo]()

            for item in guardObject {
                let object: UserInfo = UserInfo()

                object.statusMessage =  item["statusMessage"] as? String
                object.email =  item["email"] as? String
                object.profilePicture =  (item["profilePicture"] as? PFFile)?.url
                object.nickName =  item["nickName"] as? String
                object.userId =  item["userId"] as! String
                object.postsCount = item["postsCount"] as? Int
                object.followingCount = item["followingCount"] as? Int
                object.followersCount = item["followersCount"] as? Int

                retInfos.append(object)
                
            }
            return retInfos

        }

        return nil
    }

    
    
}
