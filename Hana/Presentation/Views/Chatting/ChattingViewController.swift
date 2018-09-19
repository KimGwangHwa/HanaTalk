//
//  TalkRoomViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit
import RxCocoa
import RxSwift

class ChattingViewController: UIViewController {

    fileprivate let reciveTextCellIdentifier = R.reuseIdentifier.receiveTextCell.identifier
    fileprivate let SendTextCellIdentifier = R.reuseIdentifier.sendTextCell.identifier
    fileprivate let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextView: HanaTextView!
    @IBOutlet weak var sendButton: UIButton!

    var presenter = ChattingPresenterImpl()
    var dataStore: ChattingDataStore! {
        return presenter.useCase
    }
    var talkRoom: TalkRoomEntity?
    var receiver: UserInfoEntity?
    private var currentUserInfo: UserInfoEntity! = UserInfoDao.current()!
    
    private var dataSource = [MessageEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setup()
        loadData()
    }
    
    func loadData() {
        loadTalkRoom()
    }
    
    func loadTalkRoom() {
        if let receiver = receiver {
            TalkRoomDao.findTalk(by: receiver) { (object, isSuccess) in
                self.talkRoom = object
                self.loadMessage()
            }
        } else {
            loadMessage()
        }
    }
    
    func loadMessage() {
        if let guardTalkRoom = talkRoom {
            MessageDao.find(by: guardTalkRoom) { (objects, isSuccess) in
                if let guardMessage = objects {
                    self.dataSource.append(contentsOf: guardMessage)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func setup() {
        inputTextView.placeholderAttributedText = NSAttributedString(string: "input", attributes: [.foregroundColor: UIColor.gray])
        title = receiver?.nickname
        tableView.register(R.nib.receiveTextCell(), forCellReuseIdentifier: R.reuseIdentifier.receiveTextCell.identifier)
        tableView.register(R.nib.sendTextCell(), forCellReuseIdentifier: R.reuseIdentifier.sendTextCell.identifier)
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = BackgroundColor
        //sendButton.isEnabled
        inputTextView.textView.rx.didChange.asControlEvent().subscribe { (_) in
            self.sendButton.isEnabled = !self.inputTextView.textView.text.isEmpty
        }.disposed(by: disposeBag)
        //inputTextView.textView.rx.text.bind(to: sendButton.rx.isEnabled)
        
    }
    
    // MARK: - TapEvent
    
    @IBAction func tapTableViewEvent(_ sender: UIButton) {
        view.endEditing(false)
    }

    @IBAction func sendEvent(_ sender: UIButton) {
        presenter.sendText(message: inputTextView.textView.text)
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
//            switch rowData.type {
//            case .image:
//                break
//            case .text(let text):
//                if let cell = tableView.dequeueReusableCell(withIdentifier: SendTextCellIdentifier, for: indexPath) as? SendTextCell {
//                    cell.message = rowData
//                    return cell
//                }
//                break
//            default:
//                break
//            }

        } else {
//            switch rowData.type {
//            case MessageType.image.rawValue:
//                break
//            case MessageType.text.rawValue:
//                if let cell = tableView.dequeueReusableCell(withIdentifier: reciveTextCellIdentifier, for: indexPath) as? ReceiveTextCell {
//                    cell.message = rowData
//                    return cell
//                }
//                break
//            default:
//                break
//            }
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
        if let guardMessage = notification?.object as? MessageEntity {
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
