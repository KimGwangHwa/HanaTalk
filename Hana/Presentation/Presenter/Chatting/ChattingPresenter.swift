//
//  ChattingPresenter.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/09.
//

import UIKit

protocol ChattingPresenter: class {
    func sendText(message: String?)
    func tapMore()
    
    func didSendMessage()
}

class ChattingPresenterImpl: ChattingPresenter {
    weak var viewInput: ChattingInputView?
    var useCase = ChattingUseCaseImpl()

    func sendText(message: String?) {
        useCase.sendText(message: message)
    }
    func tapMore() {
        
    }
    func didSendMessage() {
        viewInput?.didSendMessage()
    }
}
