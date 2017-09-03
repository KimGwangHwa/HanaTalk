//
//  TalkRoomViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit

class TalkRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DidReceiveMessageDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var inputTextField: UITextField!
    
    public var senderUser: User? = nil
    
    private var dataSource = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addKeyBoardObserver()
        setUpView()
        createChatRoom()
        
    }
    
    func createChatRoom() {
        RemoteChatManager.shared.addDelegate(self)
        RemoteChatManager.shared.createChatRoom(userId: [senderUser?.userName ?? ""]) { (isSuccess) in
            
        }
    }
    
    func setUpView() {
        title = senderUser?.nickName
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
    
    // MARK: - KeyBoardObserver
    
    func addKeyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyBoardObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification?) {
        let rect = (notification?.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double
        let height = rect?.size.height
        self.bottomConstraint.constant = height ?? 0.0

        UIView.animate(withDuration: duration!, animations: { () in
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: Notification?) {
        let duration: TimeInterval? = notification?.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Double
        self.bottomConstraint.constant = 0.0
        UIView.animate(withDuration: duration!, animations: { () in
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - TapEvent
    
    @IBAction func tapTableViewEvent(_ sender: Any) {
        view.endEditing(false)
    }

    @IBAction func sendEvent(_ sender: Any) {
        
        let sendMessage = Message.createNewRecord()
        sendMessage.sender = DataManager.shared.currentUser?.userName
        sendMessage.receiver = senderUser?.userName
        sendMessage.textMessage = inputTextField.text ?? ""
        RemoteChatManager.shared.sendMessage(sendMessage) { (isSuccess) in
            
        }
        
        dataSource.append(sendMessage)
        tableView.reloadData()
        
        inputTextField.resignFirstResponder()
        inputTextField.text = nil
    }

    // MARK: - UITabelViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = dataSource[indexPath.row]
        if rowData.responderState == .Receive {
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.receiveTextCell.identifier, for: indexPath) as? ReceiveTextCell {
                cell.message = dataSource[indexPath.row]
                cell.senderUser = senderUser
                return cell
            }
            
        } else if rowData.responderState == .Send {
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.sendTextCell.identifier, for: indexPath) as? SendTextCell {
                cell.message = dataSource[indexPath.row]
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
