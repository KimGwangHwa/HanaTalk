//
//  EventModel.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/15.
//

import UIKit
import RxSwift
import CoreLocation

class EventModel: NSObject {
    var name = Variable<String>("")
    var date = Variable<String>(Date().string(format: .date))
    var member = Variable<String>("0")
    var placeText = Variable<String>("")
    var detail = Variable<String>("")
    var place : Place?
    
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
