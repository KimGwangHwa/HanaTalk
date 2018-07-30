//
//  UserInfoRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation
import UIKit

protocol Repository {
    associatedtype Entity

    typealias BoolClosure = ((Bool)-> Void)?
    typealias CompletionClosure = ((Entity?, Bool)-> Void)?
    typealias MultipleCompletionClosure = (([Entity]?, Bool)-> Void)?

    func find(by objectId: String, closure: CompletionClosure)
    func findAll(closure: MultipleCompletionClosure)
    func save(by object: Entity, closure: BoolClosure)
    
}

extension Repository {
    
    func find(by objectId: String, closure: CompletionClosure) {
        
    }
    
    func findAll(closure: MultipleCompletionClosure) {
        
    }
    
    func save(by object: Entity, closure: BoolClosure) {
        
    }

}
