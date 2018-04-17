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
    @NSManaged var liked: UserInfo?
    @NSManaged var likedBy: UserInfo?
    @NSManaged var matched: Bool

    init(with liked: UserInfo) {
        super.init()
        self.liked = liked
        self.likedBy = DataManager.shared.currentuserInfo
    }
    
}
