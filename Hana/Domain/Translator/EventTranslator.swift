//
//  EventTranslator.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit
import Parse

struct EventTranslator: Translator {
    
    typealias Input = EventEntity
    typealias Output = EventModel

    func translate(_ input: Input?) -> Output? {
        if let input = input {
            let output = Output()
            output.rxDate.accept(input.date.string(format: .dateAndTime))
            output.rxDetail.accept(input.detail ?? "")
            output.rxMember.accept(String(input.membersCount))
            output.rxName.accept(input.name)
            output.organizer = input.organizer
            output.members = input.members
            output.imageUrl = input.imageUrl
            output.date = input.date
            let place = EventModel.Place()
            place.name = input.placeName
            place.address = input.placeAddress
            output.rxPlace.accept(place)
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
        entity.date = input.rxDate.value.date(format: .dateAndTime)!
        entity.detail = input.rxDetail.value
        entity.membersCount = Int(input.rxMember.value) ?? 0
        entity.place = PFGeoPoint(location: input.rxPlace.value.location)
        entity.name = input.rxName.value
        entity.organizer = DataManager.shared.currentuserInfo!
        entity.imageUrl = input.imageUrl
        entity.placeName = input.rxPlace.value.name
        entity.placeAddress = input.rxPlace.value.address
        return entity
    }
}
