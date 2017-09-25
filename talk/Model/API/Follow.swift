//
//  Follow.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/25.
//
//

import UIKit
import Parse

class Follow: PFObject {
    
    var userId = ""
    
    var followingUserId = ""

    class func creatFollows(with ojbects: [PFObject]?) -> [Follow] {
        var retInfos = [Follow]()
        
        if let guardObject = ojbects {
            
            for item in guardObject {
                let object = Follow()
                
                object.userId =  (item["userId"] as? String) ?? ""
                object.followingUserId =  (item["followingUserId"] as? String) ?? ""
                
                retInfos.append(object)
                
            }
        }
        
        return retInfos
    }

}
