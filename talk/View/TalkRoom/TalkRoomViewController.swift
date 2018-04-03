//
//  TalkRoomViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit

class TalkRoomViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    private var receiverUserInfo: UserInfo? = nil
    
    private var dataSource = [Message]()

    override func viewWillAppear(_ animated: Bool) {
        self.view.layoutIfNeeded()

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setUpView()
    }
    
    func setUpView() {
        title = receiverUserInfo?.nickname
        tableView.register(R.nib.receiveTextCell(), forCellReuseIdentifier: R.reuseIdentifier.receiveTextCell.identifier)
        tableView.register(R.nib.sendTextCell(), forCellReuseIdentifier: R.reuseIdentifier.sendTextCell.identifier)
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // MARK: - DidReceiveMessageDelegate
    
    func didReceiveMessage(_ message: Message?, isSuccess: Bool) {
        if let guardMessage = message {
            dataSource.append(guardMessage)
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - TapEvent
    
    @IBAction func tapTableViewEvent(_ sender: Any) {
        view.endEditing(false)
    }

    @IBAction func sendEvent(_ sender: Any) {
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

// MARK: - UITabelViewDelegate
extension TalkRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = dataSource[indexPath.row]
        /*
         
         if rowData.responderState == .Receive {
         if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.receiveTextCell.identifier, for: indexPath) as? ReceiveTextCell {
         cell.message = dataSource[indexPath.row]
         cell.receiver = receiverUserInfo
         return cell
         }
         
         } else if rowData.responderState == .Send {
         if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sendTextCell.identifier, for: indexPath) as? SendTextCell {
         cell.message = dataSource[indexPath.row]
         return cell
         }
         }
         */
        return UITableViewCell()
    }
}

// MARK: - NotificationCenter

extension TalkRoomViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidReceive(notification:)), name: .PushNotificationDidRecive, object: nil)
    }
    
    

    @objc func pushNotificationDidReceive(notification: Notification?) {
        
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
