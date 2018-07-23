//
//  CategoryEntity.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit
import Parse

enum CategoryType: Int {
    case wantTodo = 0
    case event
}

class CategoryEntity: PFObject, PFSubclassing {

    static func parseClassName() -> String {
        return TalkRoomClassName
    }
    
    var type: CategoryType {
        set {
            self["type"] = newValue.rawValue
        }
        get {
            let type = self["type"]
            let typeInt = type as? Int
            return CategoryType(rawValue: typeInt ?? 0)!
        }
    }
    
    @NSManaged var name: String
    //@NSManaged var type: Int
    
}
