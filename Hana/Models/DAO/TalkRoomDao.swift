//
//  TalkRoomDao.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/15.
//

import UIKit
import Parse

class TalkRoomDao: DAO {
    class func findTalk(closure: @escaping ([TalkRoom]?)-> Void) {
        localFind(with: TalkRoomClassName, closure: closure)
    }
}
