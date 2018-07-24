//
//  Like.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/18.
//

import UIKit
import Parse

class Like: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return LikeClassName
    }
    @NSManaged var liked: UserInfoEntity?
    @NSManaged var likedBy: UserInfoEntity?
    @NSManaged var matched: Bool

    init(with liked: UserInfoEntity) {
        super.init()
        self.liked = liked
        self.likedBy = DataManager.shared.currentuserInfo
    }
    
    override init() {
        super.init()
    }
    
    var receiver: UserInfoEntity! {
        if DataManager.shared.currentuserInfo == liked {
            return likedBy
        } else {
            return liked
        }
    }
    
    
}
