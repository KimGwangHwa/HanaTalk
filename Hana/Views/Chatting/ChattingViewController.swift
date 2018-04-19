//
//  TalkRoomViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit

class ChattingViewController: UIViewController {

    fileprivate let reciveTextCellIdentifier = R.reuseIdentifier.receiveTextCell.identifier
    fileprivate let SendTextCellIdentifier = R.reuseIdentifier.sendTextCell.identifier

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    var talkRoom: TalkRoom?
    var receiver: UserInfo?
    private var currentUserInfo: UserInfo! = DataManager.shared.currentuserInfo!
    
    private var dataSource = [Message]()

    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setUpView()
        loadData()
    }
    
    func loadData() {
        if let guardTalkRoom = talkRoom {
            MessageDao.find(by: guardTalkRoom) { (objects, isSuccess) in
                if let guardMessage = objects {
                    self.dataSource.append(contentsOf: guardMessage)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func setUpView() {
        title = receiver?.nickname
        tableView.register(R.nib.receiveTextCell(), forCellReuseIdentifier: R.reuseIdentifier.receiveTextCell.identifier)
        tableView.register(R.nib.sendTextCell(), forCellReuseIdentifier: R.reuseIdentifier.sendTextCell.identifier)
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - TapEvent
    
    @IBAction func tapTableViewEvent(_ sender: UIButton) {
        view.endEditing(false)
    }

    @IBAction func sendEvent(_ sender: UIButton) {

        let message = Message(text: inputTextField.text!)
        message.saveInBackground { (isSuccess, error) in
            if let guardTalkRoom = self.talkRoom {
                message.talkRoom = guardTalkRoom
                guardTalkRoom.lastMessage = message
                ParseHelper.sendPush(with: message) { (isSuccess) in
                    self.dataSource.append(message)
                    self.inputTextField.text = nil
                    self.inputTextField.resignFirstResponder()
                    self.tableView.reloadData()
                }
                guardTalkRoom.saveInBackground()
            }
            if let guardReceiver = self.receiver {
                let room = TalkRoom(members: [self.currentUserInfo, guardReceiver])
                room.lastMessage = message
                message.talkRoom = room
                room.saveInBackground { (isSuccess, error) in
                    ParseHelper.sendPush(with: message) { (isSuccess) in
                        self.dataSource.append(message)
                        self.inputTextField.text = nil
                        self.inputTextField.resignFirstResponder()
                        self.tableView.reloadData()
                    }
                }
                self.receiver = nil
                self.talkRoom = room
            }
        }
        
        
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - UITabelViewDelegate
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = dataSource[indexPath.row]
        if rowData.sender == currentUserInfo {
            switch rowData.type {
            case MessageType.image.rawValue:
                break
            case MessageType.text.rawValue:
                if let cell = tableView.dequeueReusableCell(withIdentifier: SendTextCellIdentifier, for: indexPath) as? SendTextCell {
                    cell.message = rowData
                    return cell
                }
                break
            default:
                break
            }

        } else if (rowData.sender == receiver) {
            switch rowData.type {
            case MessageType.image.rawValue:
                break
            case MessageType.text.rawValue:
                if let cell = tableView.dequeueReusableCell(withIdentifier: reciveTextCellIdentifier, for: indexPath) as? ReceiveTextCell {
                    cell.message = rowData
                    return cell
                }
                break
            default:
                break
            }
        }
        return UITableViewCell()
    }
}

// MARK: - NotificationCenter

extension ChattingViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidReceive(notification:)), name: .PushNotificationDidRecive, object: nil)
    }
    
    @objc func pushNotificationDidReceive(notification: Notification?) {
        if let guardMessage = notification?.object as? Message {
            if guardMessage.sender?.objectId == receiver?.objectId {
                dataSource.append(guardMessage)
                tableView.reloadData()
            }
        }
    }

    @objc func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        let height = rect?.size.height
        self.bottomConstraint.constant = height ?? 0.0
        
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        self.bottomConstraint.constant = 0.0
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.layoutIfNeeded()
        })
    }

    
}
