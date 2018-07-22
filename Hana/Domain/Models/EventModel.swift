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
    var rxName = BehaviorRelay<String>(value: "")
    var rxDate = BehaviorRelay<String>(value: Date().string(format: .dateAndTime))
    var rxMember = BehaviorRelay<String>(value: "0")
    var rxPlaceText = BehaviorRelay<String>(value: "")
    var rxDetail = BehaviorRelay<String>(value: "")
    var rxPlace = BehaviorRelay<Place>(value: Place())
    
    var organizer: UserInfo!
    var members: [UserInfo]?
    var imageUrl: String?
    var image: UIImage?
    var date: Date!
    
    class Place: NSObject {
        var name: String?
        var address: String?
        var location: CLLocation?
    }
    
    var isEmpty: Bool {
        if rxName.value.isEmpty || rxDate.value.isEmpty ||
            rxMember.value.isEmpty || rxPlaceText.value.isEmpty ||
            rxDetail.value.isEmpty {
            return true
        }
        return false
    }
    
}
