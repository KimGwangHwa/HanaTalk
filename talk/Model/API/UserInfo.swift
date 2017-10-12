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

    typealias CompletionHandler = (Bool) -> Void

    //var objectId = ""
    
    var statusMessage: String?
    
    var userId = ""
    
    var email: String?
    
    var phoneNumber: String?
    
    var sex: Bool = true
    
    var profilePicture: String? //URL

    //var image: UIImage? //image
    
    var nickName: String?
    
    var latitude: CGFloat = 0.0

    var longitude: CGFloat = 0.0
    
    var followingCount: Int?
    
    var followersCount: Int?
    
    var postsCount: Int?
    
    var birthday: Date?
    
    func uploadProfilePicture(image: UIImage, completion: @escaping CompletionHandler) {
        let data = image.sd_imageData()
        let pffile = PFFile(name: Common.dateToString(date: Date(), format: DATE_FORMAT_1)! + ".png", data: data!)
        
        self["profilePicture"] = pffile
        self.profilePicture = pffile?.url
        self.saveInBackground { (isSuccess, error) in
            completion(isSuccess)
        }
    }
    func upload(completion: @escaping CompletionHandler) {

        self["userId"] = DataManager.shared.currentUserInfo?.userId
        self["phoneNumber"] = DataManager.shared.currentUserInfo?.phoneNumber ?? ""
        self["statusMessage"] = DataManager.shared.currentUserInfo?.statusMessage ?? ""
        self["sex"] = DataManager.shared.currentUserInfo?.sex ?? false
        self["nickName"] = DataManager.shared.currentUserInfo?.nickName ?? ""
        self["birthday"] = DataManager.shared.currentUserInfo?.birthday ?? Date()
        
        self.saveInBackground { (isSuccess, error) in
            completion(isSuccess)
        }
    }
    
    
    
    class func creatUserInfos(with ojbects: [PFObject]?) -> [UserInfo]? {

        if let guardObject = ojbects {
            var retInfos = [UserInfo]()

            for item in guardObject {
                let object: UserInfo = UserInfo()
                object.objectId = item.objectId
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
