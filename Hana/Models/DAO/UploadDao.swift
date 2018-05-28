//
//  UploadDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/24.
//

import UIKit
import Parse

class UploadDao: NSObject {
    static func upload(image: UIImage?, closure: @escaping (String?) -> ()) {
        if let guardImage = image,
            let imageData = UIImagePNGRepresentation(guardImage), let pfile = PFFile(data: imageData) {
            pfile.saveInBackground(block: { (isSuccess, error) in
                closure(pfile.url)
            })
        }
    }
}
