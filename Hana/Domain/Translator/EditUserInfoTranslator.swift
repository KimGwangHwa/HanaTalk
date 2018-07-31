//
//  EditUserInfoTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/31.
//

import UIKit

class EditUserInfoTranslator: Translator {

    func translate(_ input: UserInfoEntity?) -> EditUserInfoModel? {
        if let input = input {
            let output = EditUserInfoModel()
            output.bio.accept(input.bio ?? "")
            output.nickname.accept(input.nickname ?? "")
            output.birthDay.accept(input.birthday?.string(format: .date) ?? "")
            output.mail.accept(input.email ?? "")
            output.tel.accept(input.phoneNumber ?? "")
            output.profileUrl = input.profileUrl ?? ""
            output.configured = input.configured
            output.objectId = input.objectId
            return output
        }
        return nil
    }
    
    func reverseTranslate(_ input: EditUserInfoModel?) -> UserInfoEntity? {
        if let input = input {
            let output = UserInfoEntity()
            output.objectId = input.objectId
            output.bio = input.bio.value
            output.nickname = input.nickname.value
            output.birthday = input.birthDay.value.date(format: .date)
            output.email = input.mail.value
            output.phoneNumber = input.tel.value
            output.profileUrl = input.profileUrl
            output.sex = Sex(name: input.sex.value)
            output.configured = true
            return output
        }
        return nil
    }
}
