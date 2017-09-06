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

        setUpTableView()
        
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
  
    private func setUpTableView() {
        tableView.register(R.nib.talkLogCell(), forCellReuseIdentifier: R.reuseIdentifier.talkLogCell.identifier)
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
    
    // RowHeight
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.talkLogViewController.talkRoom.identifier {
            if let viewController = segue.destination as? TalkRoomViewController {
                var senderUserName = ""
                if let members = selectedRoom.members as? NSArray {
                    if members.count == 1 {
                        senderUserName = (members.firstObject as? String) ?? ""
                    }
                }
                
                let senderUsers = DataManager.shared.friends.filter({$0.userName == senderUserName})
                viewController.senderUser = senderUsers.first
            }
        }
    }
    
    // MARK: -DidReceive
    
    func didReceiveMessage(_ message: Message?, isSuccess: Bool) {
//        var bageInt = Int(self.tabBarItem.badgeValue!) ?? 0
        self.navigationController?.tabBarItem.badgeValue = "1"
    
    }


    
}
