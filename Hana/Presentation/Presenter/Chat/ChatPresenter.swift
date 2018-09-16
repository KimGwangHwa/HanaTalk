//
//  ChatPresenter.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/09/16.
//

import UIKit

protocol ChatPresenter {
    func enterTalkRoom()
    func tapTabelViewItem(with indexPath: IndexPath)
    func viewDidLoad(closure: @escaping (Bool)-> Void)
}

class ChatPresenterImpl: NSObject {
    var useCase = ChatUseCaseImpl()
}

// MARK: - ChatPresenter
extension ChatPresenterImpl: ChatPresenter {
    func enterTalkRoom() {
        
    }
    func tapTabelViewItem(with indexPath: IndexPath) {

    }
    func viewDidLoad(closure: @escaping (Bool)-> Void) {
        useCase.read(closure: closure)
    }
}
