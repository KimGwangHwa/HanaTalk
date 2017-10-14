//
//  Response.swift
//  talk
//
//  Created by ひかりちゃん on 2017/10/14.
//

import UIKit

enum ResponseStatus: Int {
    case Success
    case Failure
}

typealias StatusCompletionHandler = (ResponseStatus) -> Void

class Response<T> {
    var status: ResponseStatus = .Success
    var data:T?
}
