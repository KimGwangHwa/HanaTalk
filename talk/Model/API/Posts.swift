//
//  Posts.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/03.
//

import UIKit
import Parse

class Posts: NSObject {
    public var poster: UserInfo?
//    public var title: String?
    public var objectId: String?
    public var imageUrls: [String]?
    public var messages: [Message]?
    public var likeds: [UserInfo]?
    public var contents: String?
    public var createdAt: Date?
    
    // For uploading variable
    public var images: [UIImage]?
    
    class func convertPosts(with object: PFObject?) -> Posts? {
        if let guardObject = object {
            let post = Posts()
//            post.title = guardObject["title"] as? String
            post.objectId = guardObject.objectId
            post.imageUrls = guardObject["imageUrls"] as? [String]
            post.contents = guardObject["contents"] as? String
            post.poster = UserInfo.convertUserInfo(with: guardObject["poster"] as? PFObject)
            post.createdAt = guardObject.createdAt
            
            if let messageObjects = guardObject["messages"] as? [PFObject] {
                var messages = [Message]()
                for messageObject in messageObjects {
                    messages.append(Message.convertMessage(with: messageObject) ?? Message())
                }
                post.messages = messages
            }
            
            if let likedObjects = guardObject["likeds"] as? [PFObject] {
                var likeds = [UserInfo]()
                for likedObject in likedObjects {
                    likeds.append(UserInfo.convertUserInfo(with: likedObject) ?? UserInfo())
                }
                post.likeds = likeds
            }
            return post
        }
        return nil
        
    }
}
