//
//  CategoryRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit

class CategoryRepository: Repository {
    typealias Entity = CategoryEntity

    func find(by objectId: String, closure: ((CategoryEntity?, Bool) -> Void)?) {
        
    }
    
    func findAll(closure: (([CategoryEntity]?, Bool) -> Void)?) {
        
    }
    
    func save(by object: CategoryEntity, closure: Repository.BoolClosure) {
        
    }    
}
