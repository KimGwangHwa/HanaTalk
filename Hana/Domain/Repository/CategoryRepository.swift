//
//  CategoryRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit

protocol CategoryRepository: Repository {
    
    func find(by type: CategoryType, closure: MultipleCompletionClosure)

}

struct CategoryRepositoryImpl: CategoryRepository {
    
    typealias Entity = CategoryEntity
    
    private let dao = CategoryDao()
    
    func find(by type: CategoryType, closure: MultipleCompletionClosure) {
        dao.find(by: type, closure: closure)
    }
    
    func find(by objectId: String, closure: ((CategoryEntity?, Bool) -> Void)?) {
        
    }
    
    func findAll(closure: (([CategoryEntity]?, Bool) -> Void)?) {
        
    }
    
    func save(by object: CategoryEntity, closure: Repository.BoolClosure) {
        
    }
}


