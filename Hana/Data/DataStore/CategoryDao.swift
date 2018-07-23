//
//  CategoryDao.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit
import Parse

class CategoryDao: CategoryRepository {
    
    typealias Entity = CategoryEntity
    
    func find(by type: CategoryType, closure: MultipleCompletionClosure) {
        let query = PFQuery(className: CategoryClassName)
        query.whereKey("type", equalTo: type.rawValue)
        query.findObjectsInBackground { (objects, error) in
            closure!(objects as? [CategoryEntity], error == nil ? true:false)
        }
    }
}
