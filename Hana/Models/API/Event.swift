//
//  Event.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/16.
//

import UIKit
import Parse

class Event: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return EventClassName
    }
    
    @NSManaged var name: String
    @NSManaged var date: Date
    @NSManaged var place: PFGeoPoint
    @NSManaged var members: [UserInfo]
    @NSManaged var detail: String?


}
