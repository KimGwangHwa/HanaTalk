//
//  TalkHistoryViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/25.
//

import UIKit

class ChatHistoryViewController: UIViewController {

    var searchController = UISearchController(searchResultsController: nil)
    
    fileprivate enum Section: Int {
        case matching = 0
        case history = 1
        
        static var count: Int = 2
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    let historyCellIdentifier = R.reuseIdentifier.talkHistoryCell.identifier
    let matchingCellIdentifier = R.reuseIdentifier.matchingCell.identifier
    var historys: [TalkRoom]?
    var mathings: [Like]?
    
    var filterHistorys: [TalkRoom]?
    var filterMathings: [Like]?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addObserver()
        loadData()
    }
    
    func loadData() {
        
        LikeDao.find { (objects, isSuccess) in
            self.mathings = objects
            self.tableView.reloadData()
        }
        TalkRoomDao.findTalk { (objects, isSuccess) in
            self.historys = objects
            self.tableView.reloadData()
        }
    }
    
    func setUpView() {
        setNavigationBarBackIndicatorImage(R.image.icon_back()!)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "placeholder"
        //searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        
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
            if searchController.isActive {
                return filterHistorys?.count ?? 0
            }
            return historys?.count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section.matching.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: matchingCellIdentifier, for: indexPath) as? MatchingCell {
                if searchController.isActive {
                    cell.dataSource = filterMathings
                } else {
                    cell.dataSource = mathings
                }
                cell.delegate = self
                return cell
            }
        }
        if indexPath.section == Section.history.rawValue {
            if let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as? TalkHistoryCell {
                if searchController.isActive {
                    cell.talkRoom = filterHistorys?[indexPath.row]
                } else {
                    cell.talkRoom = historys?[indexPath.row]
                }
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewController = R.storyboard.chatting.chattingViewController() {
            if searchController.isActive {
                viewController.talkRoom = filterHistorys?[indexPath.row]
            } else {
                viewController.talkRoom = historys?[indexPath.row]
            }
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - NotificationCenter
extension ChatHistoryViewController {

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidReceive(notification:)), name: .PushNotificationDidRecive, object: nil)

    }
    
    @objc func pushNotificationDidReceive(notification: Notification?) {
        loadData()
    }

    
}

// MARK: - MatchingCellDelegate
extension ChatHistoryViewController: MatchingCellDelegate {
    
    func matchingCell(_ cell: MatchingCell, didSelectItemAt object: Like) {
        if object.matched {
            if let viewController = R.storyboard.chatting.chattingViewController() {
                viewController.receiver = object.receiver
                navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            if let viewController = R.storyboard.userInfo.userInfoViewController() {
                viewController.userInfo = object.receiver
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension ChatHistoryViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, searchString.isEmpty == false {
            let predicate = NSPredicate(format: "receiver.nickname LIKE %@", argumentArray: [searchString])
            if let mathingArray = mathings as NSArray? {
                filterMathings = mathingArray.filtered(using: predicate) as? [Like]
                
            }
            if let historyArray = historys as NSArray?  {
                filterHistorys = historyArray.filtered(using: predicate) as? [TalkRoom]
            }
            tableView.reloadData()
        }
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        tableView.reloadData()
    }
    
}



