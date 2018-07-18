//
//  Translator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation

protocol Translator {
    associatedtype Input
    associatedtype Output
    
    func translate(_: Input?) -> Output?
    
    func translate(_: [Input]?) -> [Output]?

    func reverseTranslate(_: Output) -> Input

}
