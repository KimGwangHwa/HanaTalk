//
//  Response.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/14.
//

import UIKit

enum ResponseStatus: Int {
    case success
    case failure
}

typealias StatusCompletionHandler = (ResponseStatus) -> Void

class Response<T> {
    var status: ResponseStatus = .success
    var data:T?
}
