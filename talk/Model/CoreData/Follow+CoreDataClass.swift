//
//  Follow+CoreDataClass.swift
//  
//
//  Created by ひかりちゃん on 2017/10/23.
//
//

import Foundation
import CoreData
import Parse

@objc(Follow)
public class Follow: NSManagedObject {
    
    class func createNewRecord() -> Follow {
        let tweet = NSEntityDescription.entity(forEntityName: EntityName.Follow.rawValue, in: CoreDataHelper.shared.managedObjectContext)
        let follow = Follow(entity: tweet!, insertInto: CoreDataHelper.shared.managedObjectContext)
        return follow
    }
    
    class func convertFollow(with ojbects: [PFObject]?) -> [Follow]? {
        
        if let guardObject = ojbects {
            var retInfos = [Follow]()
            for item in guardObject {
                let object = Follow()
                object.userId =  (item["userId"] as? String) ?? ""
                object.followingId =  (item["followingId"] as? String) ?? ""
                retInfos.append(object)
            }
            return retInfos
        }
        return nil;
    }
}
