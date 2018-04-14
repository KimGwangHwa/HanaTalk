//
//  DAO.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/14.
//

import UIKit
import Parse

class DAO: NSObject {
    
    class func localFind(with className: String, parameters:  [String : Any]?, closure: @escaping ([PFObject]?)-> Void ) {
        let query = PFQuery(className: className)
        
        for (key, value) in parameters ?? [:] {
            query.whereKey(key, equalTo: value)

        }
        query.fromLocalDatastore()
        query.findObjectsInBackground { (objects, error) in
            closure(objects)
        }
    }

    class func remoteFind(with className: String, parameters:  [String : Any]?, closure: @escaping ([PFObject]?, Bool)-> Void ) {
        let query = PFQuery(className: className)
        
        for (key, value) in parameters ?? [:] {
            query.whereKey(key, equalTo: value)
            
        }
        
        query.findObjectsInBackground { (objects, error) in
            closure(objects, error == nil ? true: false)
        }
    }

}
