//
//  EventModel.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/15.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class EventModel: BaseModel {
    var name = BehaviorRelay<String>(value: "")
    var date = BehaviorRelay<String>(value: Date().string(format: .date))
    var member = BehaviorRelay<String>(value: "0")
    var placeText = BehaviorRelay<String>(value: "")
    var detail = BehaviorRelay<String>(value: "")
    var place = BehaviorRelay<Place>(value: Place())
    
    class Place: NSObject {
        var name: String?
        var address: String?
        var location: CLLocationCoordinate2D?
    }
    
    var isEmpty: Bool {
        if name.value.isEmpty || date.value.isEmpty ||
            member.value.isEmpty || placeText.value.isEmpty ||
            detail.value.isEmpty {
            return true
        }
        return false
    }
    
}
