//
//  EventUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit

class EventUseCase: NSObject {
    let translator = EventTranslator()
    let repository = EventRepositoryImpl()
}
