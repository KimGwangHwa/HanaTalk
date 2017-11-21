//
//  Posts+CoreDataProperties.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/20.
//
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchPostsRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }

    @NSManaged public var userId: String?
    @NSManaged public var commentIds: [String]?
    @NSManaged public var likedIds: [String]?
    @NSManaged public var title: String?
    @NSManaged public var objectId: String?
    @NSManaged public var imageUrls: [String]?

}
