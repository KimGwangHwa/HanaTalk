//
//  CategoryUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit

class CategoryUseCase: NSObject {
    var data: [CategoryModel]?
    private let repository = CategoryRepositoryImpl()
    private let translator = CategoryTranslator()
    
    func read(closure: @escaping ([CategoryModel]?, Bool)-> Void) {
        repository.find(by: .wantTodo) { (entitys, isSuccess) in
            self.data = self.translator.translate(entitys)
            closure(self.data, isSuccess)
        }
    }
}
