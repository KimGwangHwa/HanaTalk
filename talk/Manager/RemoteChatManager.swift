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

    typealias EnterTheChatRoomCompletionHandler = (Bool, ChatRoom?) -> Void
    
    typealias SendMessageCompletionHandler = (Bool, Message?) -> Void


    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    private var groupChannel: SBDGroupChannel?
    
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
    
//    func enterTheTalkRoom(channelUrl: String, completionHandler: @escaping CompletionHandler) {
//        SBDGroupChannel.getWithUrl(channelUrl) { (groupChannel, error) in
//            completionHandler(error == nil ? false : true)
//        }
//    }
    
    func enterTheChatRoom(userName: String, completionHandler: @escaping EnterTheChatRoomCompletionHandler) {
        
        if let chatRoom = ChatRoomDao.find(chatName: userName) {
            MessageDao.updateReadingStatus(with: chatRoom.name ?? "")
            SBDGroupChannel.getWithUrl(chatRoom.url ?? "") { (groupChannel, error) in
                
                self.groupChannel = groupChannel
                
                completionHandler(error == nil ? true : false, chatRoom)
            }
        } else {
            SBDGroupChannel.createChannel(withName: userName, userIds: [userName], coverUrl: nil, data: nil) { (groupChannel, error) in
                let chatRoom = ChatRoom.createNewRecord()
                chatRoom.members = [userName]//NSArray(object: userName)
                chatRoom.url = groupChannel?.channelUrl
                chatRoom.name = userName
                
                CoreDataHelper.shared.saveContext()
                
                self.groupChannel = groupChannel
                
                SBDGroupChannel.getWithUrl(groupChannel?.channelUrl ?? "") { (groupChannel, error) in
                    completionHandler(error == nil ? true : false, chatRoom)
                }
                
            }
        }
    }
    
    
    // SBDGroupChannel
//    func createChatRoom(userId: [String], completionHandler: @escaping CompletionHandler) {
//        
//        
//        SBDGroupChannel.createChannel(withUserIds: userId, isDistinct: true) { (groupChannel, error) in
//            if error == nil {
//                
//                if !ChatRoom.isExistence(chatName: groupChannel?.channelUrl ?? "") {
//                    let chatRoom = ChatRoom.createNewRecord()
//                    chatRoom.members = NSArray(array: userId)
//                    chatRoom.userName = DataManager.shared.currentUser?.userName
//                    chatRoom.chatName = groupChannel?.channelUrl
//                    
//                    CoreDataManager.shared.saveContext()
//                }
//                
//                self.groupChannel = groupChannel
//                self.enterTheTalkRoom(channelUrl: groupChannel?.channelUrl ?? "", completionHandler: completionHandler)
//            } else {
//                completionHandler(false)
//            }
//            
//        }
//    }
    func sendTextMessage(_ text: String, receiver: String, chatRoom: ChatRoom, completionHandler: @escaping SendMessageCompletionHandler) {
        
        groupChannel?.sendUserMessage(text, completionHandler: { (message, error) in
            
            if error == nil {
                let sendMessage = Message.createNewRecord()
                sendMessage.sender = DataManager.shared.currentUserInfo()?.userId ?? ""
                sendMessage.receiver = receiver
                sendMessage.textMessage = text
                sendMessage.chatName = chatRoom.name
                chatRoom.lastMessageId = sendMessage.objectId
                
                CoreDataHelper.shared.saveContext()
                completionHandler(true, sendMessage)
            }
            
        })
    }
    
    private func sendMessage(text: String, receiverUserName: NSString,completionHandler: @escaping CompletionHandler) {
        groupChannel?.sendUserMessage(text, completionHandler: { (message, error) in
            completionHandler(error == nil ? false : true)
        })
    }
    
    // MARK: - SBDChannelDelegate
    
    func channel(_ sender: SBDBaseChannel, didReceive message: SBDBaseMessage) {
        
        if let userMessage = message as? SBDUserMessage {
            if let textMessage = userMessage.message {
                
                var chatRoom = ChatRoomDao.find(chatName: sender.name)
                
                if chatRoom == nil  {
                    chatRoom = ChatRoom.createNewRecord()
                    chatRoom?.members = [(userMessage.sender?.userId) ?? ""]
                    chatRoom?.userName = DataManager.shared.currentUserInfo()?.userId ?? ""
                    chatRoom?.url = sender.channelUrl
                    chatRoom?.name = sender.name
                }
                
                let message = Message.createNewRecord()
                message.receiver = DataManager.shared.currentUserInfo()?.userId ?? ""
                message.sender = userMessage.sender?.userId
                message.textMessage = textMessage
                message.chatName = sender.name
                message.isread = false
                chatRoom?.lastMessageId = message.objectId
                chatRoom?.unreadMessageCount += 1
                
                CoreDataHelper.shared.saveContext()
                
                delegates.objectEnumerator().enumerated()
                    .map { $0.element as? DidReceiveMessageDelegate }
                    .forEach { $0?.didReceiveMessage(message, isSuccess: true) }

            }
        }
        
    }
    
}
