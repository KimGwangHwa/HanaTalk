//
//  EventTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit

struct EventTranslator: Translator {
    
    func translate(_: EventEntity) -> EventModel {
        return Output()
    }
    
    func translate(_: [EventEntity]) -> [EventModel] {
        return [EventModel]()
    }
    
    func reverseTranslate(_: EventModel) -> EventEntity {
        return EventEntity()
    }
}
