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
    let translator = EventTranslator()
    let repository = EventRepositoryImpl()
    let disposeBag = DisposeBag()
    let memberCount = ["2", "4", "6", "8", "10"];

    
    func addModelObserver(closure: @escaping ()->Void) {
        model.name.asObservable().subscribe { (string) in
            closure()
            }.disposed(by: disposeBag)
        
        model.detail.asObservable().subscribe { (string) in
            closure()
            }.disposed(by: disposeBag)
        
        model.date.asObservable().subscribe { (string) in
            closure()
            }.disposed(by: disposeBag)
        
        model.placeText.asObservable().subscribe { (count) in
            closure()
            }.disposed(by: disposeBag)
        
        model.member.asObservable().subscribe { (count) in
            closure()
            }.disposed(by: disposeBag)
    }
    
    func create(closure: Repository.BoolClosure) {
        repository.save(by: model, closure: closure)
    }
    
    
    
    
}
