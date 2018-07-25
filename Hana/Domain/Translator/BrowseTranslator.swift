//
//  BrowseTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/25.
//

import UIKit

class BrowseTranslator: Translator {
    func translate(_ input: UserInfoEntity?) -> BrowseModel? {
        if let input = input {
            let model = BrowseModel()
            model.age = input.birthday?.age ?? 0
            model.name = input.nickname
            model.imageUrls = input.albums ?? []
            model.profileUrl = input.profileUrl ?? ""
            return model
        }
        return nil
    }
}
