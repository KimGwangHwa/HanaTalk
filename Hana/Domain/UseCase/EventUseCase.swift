//
//  EventUseCase.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import UIKit
import RxSwift

enum EventRow: String {
    case name = "Event Name"
    case detail = "Detail"
    case date = "Date"
    case place = "Place"
    case member = "Member"
}

class EventUseCase: NSObject {
    
    let model = EventModel()
    private let translator = EventTranslator()
    private let repository = EventRepositoryImpl()
    private let imageRepository = ImageUploadRepositoryImpl()
    let disposeBag = DisposeBag()
    let memberCount = ["2", "4", "6", "8", "10"];
    private var eventList: [EventModel]?
    
    //let tapEvent = PublishSubject<Void>()

    var isEmpty: Bool {
        return model.isEmpty
    }
    
    func bind(closure: @escaping ()->Void) {
        model.rxName.asObservable().subscribe { (string) in
            closure()
            }.disposed(by: disposeBag)
        
        model.rxDetail.asObservable().subscribe { (string) in
            closure()
            }.disposed(by: disposeBag)
        
        model.rxDate.asObservable().subscribe { (string) in
            closure()
            }.disposed(by: disposeBag)
        
        model.rxMember.asObservable().subscribe { (count) in
            closure()
            }.disposed(by: disposeBag)

        model.rxPlace.asDriver().drive(onNext: { (place) in
            self.model.rxPlaceText.accept(place.name ?? "")
            closure()
        }).disposed(by: disposeBag)
        
    }
    
    func create(closure: Repository.BoolClosure) {
        
        imageRepository.upload(image: model.image) { (imageUrl, isSuccess) in
            if isSuccess {
                self.model.imageUrl = imageUrl
                self.repository.save(by: self.translator.reverseTranslate(self.model), closure: closure)
            }
        }
        
    }
    
    func read(closure: @escaping ([EventModel]?, Bool)-> Void) {
        repository.findAll { (entitys, isSuccess) in
            if isSuccess {
                self.eventList = self.translator.translate(entitys)
                closure(self.eventList, isSuccess)
            } else {
                closure(nil, isSuccess)
            }
        }
    }
    
    func accpet(date: Date? = nil, member: String? = nil, place: EventModel.Place? = nil, image: UIImage? = nil) {
        
        if let date = date {
            model.date = date
            model.rxDate.accept(date.string(format: .dateAndTime))
        }
        
        if let place = place {
            model.rxPlace.accept(place)
        }
        
        if let member = member {
            model.rxMember.accept(member)
        }
        
        if let image = image {
            model.image = image
        }
    }
    
    
    
}
