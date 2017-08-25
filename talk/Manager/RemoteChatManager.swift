//
//  RemoteChatManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/25.
//
//

import UIKit
import SendBirdSDK

class RemoteChatManager: NSObject, SBDChannelDelegate {

    static let shared = RemoteChatManager()
    
    typealias CompletionHandler = (Bool) -> Void
//    typealias DisconnectCompletionHandler = () -> Void
//    typealias CreateTalkRoomCompletionHandler = (Bool) -> Void
//    typealias TalkRoomListCompletionHandler = (Bool) -> Void
//    typealias SendTextMessageCompletionHandler = (Bool) -> Void
    
    private var groupChannel: SBDGroupChannel?
    

    private override init() {
        super.init()
        SBDMain.initWithApplicationId(SB_APPLICATIONID)
        // delegate
        SBDMain.add(self, identifier: "")
    }

    func connect(userId: String, completionHandler: @escaping CompletionHandler) {
        SBDMain.connect(withUserId: userId) { (user, error) in
            completionHandler(error == nil ? false : true)
        }
    }
    
    func disconnect(completionHandler: @escaping CompletionHandler) {
        SBDMain.disconnect { 
            completionHandler(true)
        }
    }
    
    private func enterTheTalkRoom(channelUrl: String, completionHandler: @escaping CompletionHandler) {
        SBDGroupChannel.getWithUrl(channelUrl) { (groupChannel, error) in
            self.groupChannel = groupChannel
            completionHandler(error == nil ? false : true)
        }
    }
    
    // SBDGroupChannel
    func createTalkRoom(userId: [String], completionHandler: @escaping CompletionHandler) {
        SBDGroupChannel.createChannel(withUserIds: userId, isDistinct: true) { (groupChannel, error) in
            if error != nil {
                self.enterTheTalkRoom(channelUrl: groupChannel?.channelUrl ?? "", completionHandler: completionHandler)
            } else {
                completionHandler(false)
            }
            
        }
    }
    
    func sendTextMessage(text: String, completionHandler: @escaping CompletionHandler) {
        groupChannel?.sendUserMessage(text, completionHandler: { (message, error) in
            completionHandler(error == nil ? false : true)
        })
    }
    
    
    
    // MARK: - SBDChannelDelegate
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        
    }
    
}
