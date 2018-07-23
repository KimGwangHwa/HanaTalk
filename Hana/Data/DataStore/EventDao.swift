//
//  EventDao.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit
import Parse

class EventDao: Repository {
    typealias Entity = EventEntity
    
    func find(by objectId: String, closure: CompletionClosure) {
        let query = PFQuery(className: EventClassName)
        query.includeKey("members")
        query.includeKey("organizer")
        query.whereKey(ObjectIdColumnName, equalTo: objectId)
        query.findObjectsInBackground { (objects, error) in
            closure!(objects?.first as? EventEntity, error == nil ? true:false)
        }
    }
    
    func findAll(closure: MultipleCompletionClosure) {
        let query = PFQuery(className: EventClassName)
        query.includeKey("members")
        query.includeKey("organizer")
        query.findObjectsInBackground { (objects, error) in
            closure!(objects as? [EventEntity], error == nil ? true:false)
        }
    }
    
    func save(by object: Entity, closure: Repository.BoolClosure) {
        object.saveInBackground { (isSuccess, error) in
            closure!(isSuccess)
        }
    }
    

}
