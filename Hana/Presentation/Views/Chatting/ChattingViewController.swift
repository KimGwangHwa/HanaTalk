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

protocol ChattingInputView: class {
    func didSendMessage()
    func networkFailure()
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        inputTextView.placeholderAttributedText = NSAttributedString(string: "input", attributes: [.foregroundColor: UIColor.gray])
        title = receiver?.nickname
        tableView.register(R.nib.receiveTextCell(), forCellReuseIdentifier: R.reuseIdentifier.receiveTextCell.identifier)
        tableView.register(R.nib.sendTextCell(), forCellReuseIdentifier: R.reuseIdentifier.sendTextCell.identifier)
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = HanaBackgroundColor
        //sendButton.isEnabled
        inputTextView.textView.rx.didChange.asControlEvent().subscribe { (_) in
            self.sendButton.isEnabled = !self.inputTextView.textView.text.isEmpty
        }.disposed(by: disposeBag)
        //inputTextView.textView.rx.text.bind(to: sendButton.rx.isEnabled)
        presenter.viewInput = self
        addObserver()
    }
    
    // MARK: - TapEvent
    
    @IBAction func tapTableViewEvent(_ sender: UIButton) {
        view.endEditing(false)
    }

    @IBAction func sendEvent(_ sender: UIButton) {
        presenter.sendText(message: inputTextView.textView.text)
        inputTextView.textView.resignFirstResponder()
        inputTextView.textView.text = nil
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - UITabelViewDelegate
extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.messageModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = dataStore.messageModels[indexPath.row]
        if rowData.isSelf {
            switch rowData.type! {
            case .image:
                break
            case .text(let text):
                if let cell = tableView.dequeueReusableCell(withIdentifier: SendTextCellIdentifier, for: indexPath) as? SendTextCell {
                    cell.config(with: text, driver: rowData.state)
                    return cell
                }
            }
        } else {
            switch rowData.type! {
            case .image:
                break
            case .text(let text):
                if let cell = tableView.dequeueReusableCell(withIdentifier: reciveTextCellIdentifier, for: indexPath) as? ReceiveTextCell {
                    cell.config(with: text, url: rowData.profileUrl)
                    return cell
                }
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
        if let guardMessage = notification?.object as? MessageEntity {
//            if guardMessage.sender?.objectId == receiver?.objectId {
//                dataSource.append(guardMessage)
//                tableView.reloadData()
//            }
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

// MARK: - ChattingInputView
extension ChattingViewController: ChattingInputView {
    
    func didSendMessage() {

    }
    
    func networkFailure() {
        
    }
}
