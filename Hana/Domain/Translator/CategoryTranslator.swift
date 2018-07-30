//
//  CategoryTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit

class CategoryTranslator: Translator {
    typealias Input = CategoryEntity
    typealias Output = CategoryModel
    
    func translate(_ input: CategoryEntity?) -> CategoryModel? {
        if let input = input {
            let output = CategoryModel()
            output.imageUrl = input.image.url
            output.name = input.name
            output.type = input.type
            output.objectId = input.objectId
            return output
        }
        return nil
    }
    
    func translateUserInfo(_ input: CategoryModel?) -> UserInfoEntity? {
        if let input = input {
            let currentUserInfo = UserInfoDao.current()!
            currentUserInfo.todayWantCategory = CategoryEntity(withoutDataWithObjectId: input.objectId)
            currentUserInfo.todayWantEnd = Date.tomorrow
            return currentUserInfo
        }
        return nil
    }
}
