//
//  EventTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit

struct EventTranslator: Translator {
    
    typealias Input = EventEntity
    typealias Output = EventModel

    func translate(_ input: Input?) -> Output? {
        if let input = input {
            let output = Output()
            output.date.accept(input.date.string(format: .dateAndTime))
            output.detail.accept(input.detail ?? "")
            output.member.accept(String(input.membersCount))
            output.name.accept(input.name)
            return output
        }
        return nil
    }
    
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

    func reverseTranslate(_ input: EventModel) -> EventEntity {
        let entity = EventEntity()
        entity.date = input.date.value.date(format: .dateAndTime)!
        entity.detail = input.detail.value
        entity.membersCount = Int(input.member.value) ?? 0
        //entity.place
        entity.name = input.name.value
        
        return entity
    }
}
