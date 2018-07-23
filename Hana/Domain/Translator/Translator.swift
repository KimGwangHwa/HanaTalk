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
    
    func reverseTranslate(_: Output?) -> Input?

}

extension Translator {
    func translate(_ input: [Input]?) -> [Output]? {
        if let input = input, !input.isEmpty {
            var output = [Output]()
            for item in input {
                if let translateItem = translate(item) {
                    output.append(translateItem)
                }
            }
            return output
        }
        return nil

    }
    
    func reverseTranslate(_: Output?) -> Input? {
        return nil
    }


}
