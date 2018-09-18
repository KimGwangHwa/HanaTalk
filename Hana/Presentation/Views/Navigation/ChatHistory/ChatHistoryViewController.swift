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
    let present = ChatPresenterImpl()
    var dataStore: ChatDataStore {
        return present.useCase
    }
    let historyCellIdentifier = R.reuseIdentifier.talkHistoryCell.identifier
    let matchingCellIdentifier = R.reuseIdentifier.matchingCell.identifier

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
        addObserver()
        loadData()
    }
    
    private func loadData() {
        present.viewDidLoad { (isSuccess) in
            self.tableView.reloadData()
        }
    }
    
    func setUpView() {
        view.backgroundColor = BackgroundColor
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "icon_chat"))
        navigationBarBackgroundImageIsHidden = true
        setNavigationBarBackIndicatorImage(#imageLiteral(resourceName: "icon_back"))
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "placeholder"
        //searchController.hidesNavigationBarDuringPresentation = false
        //searchController.dimsBackgroundDuringPresentation = true
        //.obscuresBackgroundDuringPresentation
        //searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.talkHistoryCell(), forCellReuseIdentifier: historyCellIdentifier)
        tableView.register(R.nib.matchingCell(), forCellReuseIdentifier: matchingCellIdentifier)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func moveScreen(by model: ChatModel) {
        if model.matched {
            moveTalkRoom()
        } else {
            if let viewController = R.storyboard.userInfo.userInfoViewController() {
                viewController.usecase.objectId = model.subObjectId
                viewController.usecase.isSelf = false
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func moveTalkRoom(with model: TalkRoomModel? = nil, subObject: String? = nil) {
        if let viewController = R.storyboard.chatting.chattingViewController() {
            if let subObject = subObject {
                viewController.dataStore.findTalkRoom(by: subObject)
            }
            if let model = model {
                viewController.dataStore.enterTakRoom(with: model.objectId)
            }
            navigationController?.show(viewController, sender: self)
        }
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
        return dataStore.section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataStore.likeModels.count
        }
        return dataStore.talkModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: matchingCellIdentifier, for: indexPath) as? MatchingCell {
                if searchController.isActive {
                    //cell.dataSource = filterMathings
                } else {
                    cell.config(with: dataStore.likeModels) { (model) in
                        self.moveScreen(by: model)
                    }
                }
                return cell
            }
        }
        if indexPath.section == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: historyCellIdentifier, for: indexPath) as? TalkHistoryCell {
                if searchController.isActive {
                    //cell.talkRoom = filterHistorys?[indexPath.row]
                } else {
                    cell.model = dataStore.talkModels[indexPath.row]
                }
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        moveTalkRoom(with:  dataStore.talkModels[indexPath.row])
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



