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

    typealias GetUserInfoCompletionHandler = (Response<UserInfo>) -> Void

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
    
    func uploadProfilePicture(image: UIImage, completion: @escaping StatusCompletionHandler) {
        let data = image.sd_imageData()
        let pffile = PFFile(name: Common.dateToString(date: Date(), format: DATE_FORMAT_1)! + ".png", data: data!)
        
        self["profilePicture"] = pffile
        self.profilePicture = pffile?.url
        self.saveInBackground { (isSuccess, error) in
            completion(isSuccess == true ? .Success: .Failure)
        }
    }
    
    func remoteSaveRecord(completion: @escaping StatusCompletionHandler) {
        self["userId"] = self.userId
        self["phoneNumber"] = self.phoneNumber ?? ""
        self["statusMessage"] = self.statusMessage ?? ""
        self["sex"] = self.sex
        self["nickName"] = self.nickName ?? ""
        self["birthday"] = self.birthday ?? Date()
        
        self.saveInBackground { (isSuccess, error) in
            completion(isSuccess == true ? .Success: .Failure)
        }

    }
    
    class func convertUserInfos(with ojbects: [PFObject]?) -> [UserInfo]? {

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

    class func findUserInfo(with userId: String, completion: @escaping GetUserInfoCompletionHandler) {
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
}
