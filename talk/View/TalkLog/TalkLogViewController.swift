//
//  TalkLogViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/07.
//
//

import UIKit

class TalkLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DidReceiveMessageDelegate {

    
    private var dataSource = DataManager.shared.chatRooms
    
    private var selectedRoom: ChatRoom! = nil
    
    @IBOutlet weak var tableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource = DataManager.shared.chatRooms
        tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
  
    private func setUpView() {
        tableView.register(R.nib.talkLogCell(), forCellReuseIdentifier: R.reuseIdentifier.talkLogCell.identifier)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = 60.0

    }
    
    private func reloadBadgeData() {

        var unreadCount = 0
        for room in dataSource {
            unreadCount += Int(room.unreadMessageCount)
        }
        
        navigationController?.tabBarItem.badgeValue = "\(unreadCount)"
        
    }
    
    
    // MARK: - TabelViewDelegate

    // CellRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.talkLogCell.identifier, for: indexPath) as? TalkLogCell {
            cell.data = dataSource[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    // RowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    // DidSelect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        selectedRoom = dataSource[indexPath.row]

        self.performSegue(withIdentifier: R.segue.talkLogViewController.talkRoom.identifier, sender: nil)
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.talkLogViewController.talkRoom.identifier {
            if let viewController = segue.destination as? TalkRoomViewController {
                if let members = selectedRoom.members, members.count == 1 {
                    viewController.receiverUserId = members.first ?? ""
                }
            }
        }
    }
    
    // MARK: -DidReceive
    
    func didReceiveMessage(_ message: Message?, isSuccess: Bool) {

        reloadBadgeData()
        
        if (tableView != nil) {
            tableView.reloadData()
        }
    
    }


    
}
