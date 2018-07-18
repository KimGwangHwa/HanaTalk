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

    func translate(_: Input?) -> Output? {
        return EventModel()
    }
    
    func translate(_: [Input]?) -> [Output]? {
        return [EventModel]()
    }

    func reverseTranslate(_: EventModel) -> EventEntity {
        return EventEntity()
    }
}
