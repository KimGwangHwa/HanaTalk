//
//  LikeEntity.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit
import Parse

class LikeEntity: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return LikeClassName
    }
    
    @NSManaged var liked: [UserInfoEntity]?
    @NSManaged var likedBy: [UserInfoEntity]?
    @NSManaged var organizer: UserInfoEntity!
}
