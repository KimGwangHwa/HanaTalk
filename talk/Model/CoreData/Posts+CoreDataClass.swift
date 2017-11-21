//
//  Posts+CoreDataClass.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/20.
//
//

import Foundation
import CoreData
import Parse

@objc(Posts)
public class Posts: NSManagedObject {
    
    class func createNewRecord() -> Posts {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.Posts.rawValue, in: CoreDataHelper.shared.managedObjectContext)
        let posts = Posts(entity: tweet!, insertInto: CoreDataHelper.shared.managedObjectContext)
        return posts
    }
    
    class func convertPosts(with ojbects: [PFObject]?) -> [Posts]? {
        
        if let guardObject = ojbects {
            var retInfos = [Posts]()
            for item in guardObject {
                let object: Posts = Posts.createNewRecord()
                object.objectId = item.objectId ?? ""
                object.userId =  (item["userId"] as? String) ?? ""
                object.commentIds =  item["commentIds"] as? [String]
                object.likedIds =  item["likedIds"] as? [String]
                object.title =  item["title"] as? String
                object.imageUrls =  item["imageUrls"] as? [String]
                retInfos.append(object)
            }
            return retInfos
        }
        return nil
    }
}
