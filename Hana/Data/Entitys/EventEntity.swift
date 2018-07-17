//
//  Event.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/16.
//

import UIKit
import Parse

class EventEntity: PFObject, PFSubclassing {
    
    static func parseClassName() -> String {
        return EventClassName
    }
    
    @NSManaged var name: String?
    @NSManaged var date: Date?
    @NSManaged var place: PFGeoPoint
    @NSManaged var members: [UserInfo]
    @NSManaged var membersCount : Int
    @NSManaged var detail: String?
    @NSManaged var organizer: UserInfo?


}
