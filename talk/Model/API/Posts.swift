//
//  Posts.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Posts: NSObject {
    public var userId: String?
    public var commentIds: [String]?
    public var likedIds: [String]?
    public var title: String?
    public var objectId: String?
    public var imageUrls: [String]?
    
    class func convertPosts(with object: PFObject?) -> Posts? {
        return nil
        
    }
}
