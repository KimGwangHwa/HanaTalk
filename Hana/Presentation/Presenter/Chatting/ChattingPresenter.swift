//
//  ChattingPresenter.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/09.
//

import UIKit

protocol ChattingPresenter {
    func sendMessage()
    func more()
}

class ChattingPresenterImpl: ChattingPresenter {
    var useCase = ChattingUseCaseImpl()

    func sendMessage() {
        
    }
    func more() {
        
    }
}
