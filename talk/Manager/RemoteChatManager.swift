//
//  RemoteChatManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/25.
//
//

import UIKit
import SendBirdSDK

protocol DidReceiveMessageDelegate: NSObjectProtocol {
    func didReceiveMessage(_ message: Message?, isSuccess: Bool) -> Void
}

class RemoteChatManager: NSObject, SBDChannelDelegate {

    static let shared = RemoteChatManager()
    
    typealias CompletionHandler = (Bool) -> Void

    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    private var groupChannel: SBDGroupChannel?
    
    weak var d: DidReceiveMessageDelegate?

    private override init() {
        super.init()
        SBDMain.initWithApplicationId(SB_APPLICATIONID)
        // delegate
        SBDMain.add(self, identifier: "")
    }

    func addDelegate(_ delegate: AnyObject)  {
        delegates.add(delegate)
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
            completionHandler(error == nil ? false : true)
        }
    }
    
    // SBDGroupChannel
    func createChatRoom(userId: [String], completionHandler: @escaping CompletionHandler) {
        SBDGroupChannel.createChannel(withUserIds: userId, isDistinct: true) { (groupChannel, error) in
            if error == nil {
                
                if !ChatRoom.isExistence(chatName: groupChannel?.channelUrl ?? "") {
                    let chatRoom = ChatRoom.createNewRecord()
                    chatRoom.members = NSArray(array: userId)
                    chatRoom.userName = DataManager.shared.currentUser?.userName
                    chatRoom.chatName = groupChannel?.channelUrl
                    
                    CoreDataManager.shared.saveContext()
                }
                
                self.groupChannel = groupChannel
                self.enterTheTalkRoom(channelUrl: groupChannel?.channelUrl ?? "", completionHandler: completionHandler)
            } else {
                completionHandler(false)
            }
            
        }
    }
    
    func sendMessage(_ message: Message, completionHandler: @escaping CompletionHandler) {
        if message.messageState == .Text {
            sendTextMessage(text: message.textMessage ?? "", completionHandler: { (isSuccess) in
                completionHandler(isSuccess)
                if isSuccess {
                    RemoteAPIManager.shared.saveRemoteClass(message: message)
                }
            })
        }
    }
    
    func sendTextMessage(text: String, completionHandler: @escaping CompletionHandler) {
        groupChannel?.sendUserMessage(text, completionHandler: { (message, error) in
            completionHandler(error == nil ? false : true)
        })
    }
    
    // MARK: - SBDChannelDelegate
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        
        if let userMessage = message as? SBDUserMessage {
            if let textMessage = userMessage.message {
                
                if ChatRoom.isExistence(chatName: sender.channelUrl) {
                    let chatRoom = ChatRoom.createNewRecord()
                    chatRoom.members = NSArray(object: userMessage.sender?.userId ?? "")
                    chatRoom.userName = DataManager.shared.currentUser?.userName
                    chatRoom.chatName = sender.channelUrl
                }
                
                let message = Message.createNewRecord()
                message.receiver = DataManager.shared.currentUser?.userName
                message.sender = userMessage.sender?.userId
                message.textMessage = textMessage
                
                CoreDataManager.shared.saveContext()
                
                delegates.objectEnumerator().enumerated()
                    .map { $0.element as? DidReceiveMessageDelegate }
                    .forEach { $0?.didReceiveMessage(message, isSuccess: true) }

            }
        }
        
    }
    
}
