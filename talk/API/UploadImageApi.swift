//
//  UploadImageApi.swift
//  talk
//
//  Created by 61-201405-2054 on 2018/01/19.
//

import UIKit
import Parse

class UploadImageApi: NSObject {

//    class func uploadImage(_ image: UIImage, className: String, objectId: String, columnName: String, completion: @escaping StatusCompletionHandler) {
//        
//        let pfObject = PFObject(withoutDataWithClassName: className, objectId: objectId)
//        if let imageData = UIImagePNGRepresentation(image) {
//            pfObject[columnName] = PFFile(data: imageData)
//        }
//        PFFile(
//        pfObject.saveInBackground { (isSuccess, error) in
//            completion(isSuccess == true ? .success: .failure )
//        }
//    }
    
    class func uploadImagesInBackground(_ images: [UIImage]?, className: String, objectId: String?, columnName: String, completion: @escaping StatusCompletionHandler) {
        var uploadImages = [PFFile]()
        
        let pfObject = PFObject(withoutDataWithClassName: className, objectId: objectId)
        if let guardImages = images {
            for image in guardImages {
                if let imageData = UIImagePNGRepresentation(image), let pfile = PFFile(data: imageData) {
                    uploadImages.append(pfile)
                }
            }
        }
        pfObject[columnName] = uploadImages
        pfObject.saveInBackground { (isSuccess, error) in
            completion(isSuccess == true ? .success: .failure )
        }
    }
}
