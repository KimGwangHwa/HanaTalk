//
//  ChattingPresenter.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/09.
//

import UIKit

protocol ChattingPresenter {
    func sendText(message: String?)
    func tapMore()
}

class ChattingPresenterImpl: ChattingPresenter {
    weak var viewInput: ChattingInputView?
    var useCase = ChattingUseCaseImpl()

    func sendText(message: String?) {
        useCase.sendText(message: message)
    }
    func tapMore() {
        
    }
}
