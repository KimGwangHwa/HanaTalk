//
//  EventViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/11.
//

import UIKit
import RxSwift

class EventViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let usecase = EventUseCase()
    var data: [EventModel]!
    let cellReuseIdentifier = R.reuseIdentifier.eventCell.identifier
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        tableView.tableFooterView = UIView()
        tableView.register(R.nib.eventCell(), forCellReuseIdentifier: cellReuseIdentifier)
        
        usecase.read { (list, isSuccess) in
            if let list = list {
                self.data = list
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    @IBAction func tappedCreat(_ sender: UIButton) {
        if let viewController = R.storyboard.createEvent.instantiateInitialViewController(),
            let rootViewController = viewController.viewControllers.first as? CreateEventViewController {
            rootViewController.usecase = usecase
            present(viewController, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? EventCell {
            return cell
        }
        return UITableViewCell()
    }
}
