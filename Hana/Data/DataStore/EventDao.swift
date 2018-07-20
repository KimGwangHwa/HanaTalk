//
//  EventDao.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit
import Parse

class EventDao: EventRepository {
    
    typealias Model = EventEntity
    
    private let translator = EventTranslator()
    
    func find(by objectId: String, closure: EventRepository.CompletionClosure) {
        let query = PFQuery(className: EventClassName)
        query.includeKey("members")
        query.includeKey("organizer")
        query.whereKey(ObjectIdColumnName, equalTo: objectId)
        query.findObjectsInBackground { (objects, error) in
            closure!(objects?.first as? EventEntity, error == nil ? true:false)
        }
    }
    
    func findAll(closure: EventRepository.MultipleCompletionClosure) {
        let query = PFQuery(className: EventClassName)
        query.includeKey("members")
        query.includeKey("organizer")
        query.findObjectsInBackground { (objects, error) in
            closure!(objects as? [EventEntity], error == nil ? true:false)
        }
    }
    
    func save(by object: Model, closure: Repository.BoolClosure) {
        object.saveInBackground { (isSuccess, error) in
            closure!(isSuccess)
        }
    }
    

}
