//
//  UserInfoRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation
import UIKit

protocol Repository {
    typealias BoolClosure = ((Bool)-> Void)?
    associatedtype Model

    func save(by object: Model, closure: BoolClosure)
}
