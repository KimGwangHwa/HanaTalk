//
//  UploadDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import UIKit
import Parse

class UploadDao: ImageUploadRepository {
    
    func upload(image: UIImage?, closure: ImageUploadRepository.CompletionClosure) {
        if let guardImage = image,
            let imageData = UIImageJPEGRepresentation(guardImage, 1), let pfile = PFFile(data: imageData) {
            pfile.saveInBackground(block: { (isSuccess, error) in
                if closure != nil {
                    closure!(pfile.url, isSuccess)
                }
            })
        }
    }
    
    func save(by object: PFObject, closure: Repository.BoolClosure) {
        
    }
}

