//
//  BrowseTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class BrowseTranslator: Translator {
    func translate(_ input: UserInfoEntity?) -> UserInfoModel? {
        if let input = input {
            let model = UserInfoModel()
            model.age = input.birthday?.age ?? 0
            model.name = input.nickname
            model.imageUrls = input.albums ?? []
            model.profileUrl = input.profileUrl ?? ""
            model.objectId = input.objectId
            return model
        }
        return nil
    }
}
