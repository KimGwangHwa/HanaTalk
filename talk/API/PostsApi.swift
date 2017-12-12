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
        postsQuery.includeKeys(["poster", "likeds", "messages"])
        postsQuery.findObjectsInBackground { (pfobjects, error) in
            
            if let guardObjects = pfobjects {
                var retObjects = [Posts]()
                for object in guardObjects {
                    if let postsObject = Posts.convertPosts(with: object) {
                        retObjects.append(postsObject)
                    }
                }
                let response = Response<[Posts]>()
                response.data = retObjects
                response.status = error != nil ? .failure : .success
                completion(response)

            }
            
            
        }
    }
}
