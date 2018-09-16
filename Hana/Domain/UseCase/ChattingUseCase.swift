//
//  ChattingUseCase.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/09.
//

import UIKit

protocol ChattingDataStore {
    func findTalkRoom(by partner: String?)
    func enterTakRoom(with objectId: String?)
}

protocol ChattingUseCase {
    
}

class ChattingUseCaseImpl: ChattingUseCase {

}

// MARK: - ChattingDataStore
extension ChattingUseCaseImpl: ChattingDataStore {
    func findTalkRoom(by partner: String?) {}
    func enterTakRoom(with objectId: String?) {}
}
