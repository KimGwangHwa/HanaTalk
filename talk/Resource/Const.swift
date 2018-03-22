//
//  Const.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/02.
//
//

import UIKit


// MARK: - Enum
// MARK: - Push Notification Type
enum PushNotificationType: String {
    case image = "image"
    case text = "text"
    case object = "object"
}

// DateFormat
let DATE_FORMAT_1 = "yyyyMMddHHmmss"
let DATE_FORMAT_2 = "yyyy/MM/dd"

let UploadImageMaxCount = 6
let PinkColor = UIColor(red: CGFloat(255) / 255.0, green: CGFloat(192) / 255.0, blue: CGFloat(203) / 255.0, alpha: 1)

// MARK: - ClassName
let UserInfoClassName = "UserInfo"
let LikeClassName = "Like"
let UserClassName = "_User"

// MARK: - ColumnName
let UserColumnName = "user"
let ObjectIdColumnName = "objectId"
let NicknameColumnName = "nickname"

// MARK: - Cloud Code Function
let SendMailFunction = "sendMail"
let SendSMSFunction = "sendSMS"
let SendPushFunction = "sendPush"

// MARK: - Push Notification CustomKey
let kPushNotificationAlert = "alert"
let kPushNotificationSounds = "sounds"
let kPushNotificationBadge = "badge"
let kPushNotificationType = "type"
let kPushNotificationImageURL = "imageUrl"
let kPushNotificationText = "text"
let kPushNotificationObjectId = "objectId"
let kPushNotificationChannels = "channels"



