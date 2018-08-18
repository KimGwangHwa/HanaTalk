//
//  TalkHistoryViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/25.
//

import UIKit

fileprivate enum Section: Int {
    case matching = 0
    case history = 1
    
    static var count: Int = 2
}

class ChatHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
        
    let usecase = ChatUseCase()

    let historyCellIdentifier = R.reuseIdentifier.talkHistoryCell.identifier
    let matchingCellIdentifier = R.reuseIdentifier.matchingCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addObserver()
        loadData()
    }
    
    func loadData() {
        
        usecase.read { (isSuccess) in
            self.tableView.reloadData()
        }
    }
    
    func setUpView() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "icon_chat"))
        navigationBarBackgroundImageIsHidden = true
        setNavigationBarBackIndicatorImage(R.image.icon_back()!)
        navigationBarColor = SubColor
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "placeholder"
        //searchController.hidesNavigationBarDuringPresentation = false
        //searchController.dimsBackgroundDuringPresentation = true
        //.obscuresBackgroundDuringPresentation
        //searchController.obscuresBackgroundDuringPresentation = false
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
        return usecase.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return usecase.data[section].count != 0 ? 1:0
        }
        return usecase.data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: matchingCellIdentifier, for: indexPath) as? MatchingCell {
                if searchController.isActive {
                    //cell.dataSource = filterMathings
                } else {
                    cell.model = usecase.data[indexPath.section]
                    cell.tapEventObservable.subscribe { (row) in
                        
                    }.dispose()
                }
                return cell
            }
        }
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as? TalkHistoryCell {
                if searchController.isActive {
                    //cell.talkRoom = filterHistorys?[indexPath.row]
                } else {
                    cell.model = usecase.data[indexPath.section][indexPath.row]
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let viewController = R.storyboard.chatting.chattingViewController() {
//            if searchController.isActive {
//                viewController.talkRoom = filterHistorys?[indexPath.row]
//            } else {
//                viewController.talkRoom = historys?[indexPath.row]
//            }
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

// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension ChatHistoryViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
//        if let searchString = searchController.searchBar.text, searchString.isEmpty == false {
//            let predicate = NSPredicate(format: "receiver.nickname LIKE %@", argumentArray: [searchString])
//            if let mathingArray = mathings as NSArray? {
//                filterMathings = mathingArray.filtered(using: predicate) as? [Like]
//
//            }
//            if let historyArray = historys as NSArray?  {
//                filterHistorys = historyArray.filtered(using: predicate) as? [TalkRoomEntity]
//            }
//            tableView.reloadData()
//        }
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        tableView.reloadData()
    }
    
}



