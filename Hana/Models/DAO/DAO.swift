//
//  DAO.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class DAO: NSObject {
    
    class func localFind<T: PFObject>(with className: String, parameters:  [String : Any]? = nil, closure: @escaping ([T]?)-> Void ) {
        let query = PFQuery(className: className)
        
        for (key, value) in parameters ?? [:] {
            query.whereKey(key, equalTo: value)

        }
        query.fromLocalDatastore()
        query.findObjectsInBackground { (objects, error) in
            closure(objects as? [T])
        }
    }

    class func remoteFind<T: PFObject>(with className: String, parameters:  [String : Any]?, closure: @escaping ([T]?, Bool)-> Void ) {
        let query = PFQuery(className: className)
        
        for (key, value) in parameters ?? [:] {
            query.whereKey(key, equalTo: value)
            
        }
        
        query.findObjectsInBackground { (objects, error) in
            closure(objects as? [T], error == nil ? true: false)
        }
    }

}
