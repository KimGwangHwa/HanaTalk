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
    let disposeBag = DisposeBag()
    let memberCount = ["2", "4", "6", "8", "10"];
    private var eventList: [EventModel]?
    
    let tapEvent = PublishSubject<Void>()

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
        repository.save(by: translator.reverseTranslate(model), closure: closure)
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
    
    func accpet(place: EventModel.Place) {
        model.rxPlace.accept(place)
    }
    
    
    
}
