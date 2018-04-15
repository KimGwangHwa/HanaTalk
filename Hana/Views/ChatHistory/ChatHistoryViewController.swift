//
//  TalkHistoryViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/25.
//

import UIKit

class ChatHistoryViewController: UIViewController {

    fileprivate enum Section: Int {
        case matching = 0
        case history = 1
        
        static var count: Int = 2
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    let historyCellIdentifier = R.reuseIdentifier.talkHistoryCell.identifier
    let matchingCellIdentifier = R.reuseIdentifier.matchingCell.identifier
    var historys: [TalkRoom]?
    var mathings: [Message]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addObserver()
        loadData()
    }
    
    func loadData() {
        TalkRoomDao.findTalk { (rooms) in
            self.historys = rooms
            MessageDao.findBeLikedMessages { (messages) in
                self.mathings = messages
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.talkHistoryCell(), forCellReuseIdentifier: historyCellIdentifier)
        tableView.register(R.nib.matchingCell(), forCellReuseIdentifier: matchingCellIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @IBAction func sideMenuEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == Section.matching.rawValue {
            if let matchingCount = mathings?.count,
                matchingCount > 0 {
                return 1
            }
        } else if (section == Section.history.rawValue) {
            return historys?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.matching.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: matchingCellIdentifier, for: indexPath) as? MatchingCell {
                cell.messages = mathings
                cell.delegate = self
                return cell
            }
        }
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as? TalkHistoryCell {
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - NotificationCenter
extension ChatHistoryViewController {

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidReceive(notification:)), name: .PushNotificationDidRecive, object: nil)

    }
    
    @objc func pushNotificationDidReceive(notification: Notification?) {
        
    }

    
}

// MARK: - MatchingCellDelegate

extension ChatHistoryViewController: MatchingCellDelegate {
    
    func matchingCell(_ cell: MatchingCell, didSelectItemAt object: Message) {
        if object.matched {
            if let viewController = R.storyboard.chatting.chattingViewController() {
                viewController.receiver = object.sender
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}


