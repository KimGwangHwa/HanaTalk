//
//  PostsApi.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/20.
//

import UIKit
import Parse

class PostsApi: NSObject {
    typealias PostsListCompletionHandler = (Response<[Posts]>) -> Void
    
    class func findAllPosts(completion: @escaping PostsListCompletionHandler) {
        
        let postsQuery = PFQuery(className: "Posts")
        //query.includeKey("test")
        postsQuery.findObjectsInBackground { (pfobjects, error) in
            
            if let postsList = Posts.convertPosts(with: pfobjects) {
//                for posts in postsList {
//                    UserInfoApi.findUserInfo(with: posts.userId, completion: { (response) in
//
//                    })
//                }
            }
            
            
            
        }

    }
}
