//
//  CategoryModel.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit

class CategoryModel: BaseModel {
    var name: String!
    var imageUrl: String!
    var type: CategoryType = .wantTodo
    var image: UIImage?
}
