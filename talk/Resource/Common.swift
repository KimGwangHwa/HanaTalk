//
//  Common.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/10.
//
//

import UIKit
import Parse
import Gzip

class Common: NSObject {
    
    // MARK: - Date <-> String

    class func dateToString(date: Date?, format: String) -> String? {
        
        if let guradDate = date  {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.string(from: guradDate)
        }
        return nil
    }
    
    class func stringToDate(dateString: String?, format: String) -> Date? {
        if let guradDateString = dateString {
            let formatter = DateFormatter()
            formatter.dateFormat = format
            return formatter.date(from: guradDateString)
        }
        return nil
    }
    
    // MARK: - UIImage <-> String

    class func imageToString(image: UIImage?) -> String? {
        if let guardImage = image {
            let pngData = UIImagePNGRepresentation(guardImage)
            return pngData?.base64EncodedString(options: .endLineWithCarriageReturn)
        }
        return nil
    }
    
    class func stringToImage(base64String: String?) -> UIImage? {
        if let guardBase64String = base64String, let pngData = Data(base64Encoded: guardBase64String, options: .ignoreUnknownCharacters) {
            return UIImage(data: pngData)
        }
        return nil
    }
    
    // MARK: - UIImage <-> PFFile

    class func imageToFile(_ image: UIImage?) -> PFFile? {
        if let guardImage = image,
            let imageData = UIImagePNGRepresentation(guardImage), let pfile = PFFile(data: imageData) {
            return pfile
        }
        return nil
    }
    
    class func imagesToFile(_ images: [UIImage]?) -> PFFile? {
        if let guardImages = images {
            var base64Strings = [String]()
            
            for image in guardImages {
                base64Strings.append(self.imageToString(image: image) ?? "")
            }
            let jsonData = try? JSONSerialization.data(withJSONObject: base64Strings, options: [])
            if let guardJsonData = jsonData,
                let zipData = try? guardJsonData.gzipped() {
                return PFFile(data: zipData)
            }
        }
        return nil
    }
    
}
