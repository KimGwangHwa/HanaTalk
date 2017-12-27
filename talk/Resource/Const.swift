//
//  Const.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/02.
//
//

import UIKit

// DateFormat
let DATE_FORMAT_1 = "yyyyMMddHHmmss"
let DATE_FORMAT_2 = "yyyy/MM/dd"

// MARK: SASHIDO
// TODO: R.swift Can Not?
// ApplicationId
var SA_APPLICATIONID: String {
    if let privateInfo = Bundle.main.infoDictionary?["PrivateInfo"] as? [String: String] {
        if let value = privateInfo["SA_ApplicationId"] {
            return value
        }
    }
    return ""
}

var SA_CLIENTKEY: String {
    if let privateInfo = Bundle.main.infoDictionary?["PrivateInfo"] as? [String: String] {
        if let value = privateInfo["SA_ClientKey"] {
            return value
        }
    }
    return ""
}

var SA_SERVER: String {
    if let privateInfo = Bundle.main.infoDictionary?["PrivateInfo"] as? [String: String] {
        if let value = privateInfo["SA_Server"] {
            return value
        }
    }
    return ""
}

// MARK: SBDMain

// ApplicationId

let SB_APPLICATIONID = "DD21A9CC-A953-4633-A9B9-0E3B94137F1D"

