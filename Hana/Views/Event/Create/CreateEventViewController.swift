//
//  CreateEventViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/12.
//

import UIKit
import RxSwift
import RxCocoa

class CreateEventViewController: UITableViewController {
   
    enum EventRow: String {
        case name = "Event Name"
        case detail = "Detail"
        case date = "Date"
        case place = "Place"
        case member = "Member"
    }
    
    @IBOutlet weak var rightBarButton: UIButton!
    var eventName = Variable<String>("")
    var eventDate = Variable<Date>(Date())
    //var eventDate = Variable<Date>(Date())
    var eventMember = Variable<Int>(0)
    var eventDetail = Variable<String>("")

    let disposeBag = DisposeBag()
    
    let nameCellIdentifier = R.reuseIdentifier.createEventNameCell.identifier
    let normalCellIdentifier = R.reuseIdentifier.createEventNormalCell.identifier
    let detaillCellIdentifier = R.reuseIdentifier.createEventDetailCell.identifier
    
    var dataSource = [[EventRow.name, EventRow.detail],[EventRow.date, EventRow.place, EventRow.member]];
    
    let event = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight = 100;
        tableView.register(R.nib.createEventNameCell(), forCellReuseIdentifier: nameCellIdentifier)
        tableView.register(R.nib.createEventNormalCell(), forCellReuseIdentifier: normalCellIdentifier)
        tableView.register(R.nib.createEventDetailCell(), forCellReuseIdentifier: detaillCellIdentifier)

        eventName.asObservable().subscribe { (string) in
            self.didInputChanged()
        }.disposed(by: disposeBag)
        
        eventDetail.asObservable().subscribe { (string) in
            self.didInputChanged()
        }.disposed(by: disposeBag)
        
//        eventDate.asObservable().subscribe { (date) in
//            self.didInputChanged()
//        }.disposed(by: disposeBag)
        
        eventMember.asObservable().subscribe { (count) in
            self.didInputChanged()
            }.disposed(by: disposeBag)
    }
    
    @IBAction func tappedCreat(_ sender: UIButton) {
        
        event.date = eventDate.value
        event.name = eventName.value
        event.membersCount = eventMember.value
        event.detail = eventDetail.value
        event.organizer = DataManager.shared.currentuserInfo
        event.saveInBackground { (isSuccess, error) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tappedCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func didInputChanged() {
        tableView.reloadData()
        if !eventDetail.value.isBlank && !eventName.value.isBlank &&
        eventMember.value != 0 {
            rightBarButton.isEnabled = true
        } else {
            rightBarButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = dataSource[indexPath.section][indexPath.row]
        switch row {
        case .name:
            if let cell = tableView.dequeueReusableCell(withIdentifier: nameCellIdentifier, for: indexPath) as? CreateEventNameCell {
                cell.textField.placeholder = row.rawValue
                _ = cell.textField.rx.text.map { $0 ?? "" }.bind(to: eventName)
                return cell
            }
            break
        case .detail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: detaillCellIdentifier, for: indexPath) as? CreateEventDetailCell {
                cell.placeholder = row.rawValue
                _ = cell.textView.rx.text.map { $0 ?? "" }.bind(to: eventDetail)
                return cell
            }
            break
        case .date, .place, .member:
            if let cell = tableView.dequeueReusableCell(withIdentifier: normalCellIdentifier, for: indexPath) as? CreateEventNormalCell {
                cell.textLabel?.text = row.rawValue
                if row == .date {
                    cell.detailTextLabel?.text = eventDate.value.string(format: .date)
                } else if (row == .place) {
                    cell.detailTextLabel?.text = row.rawValue
                } else if (row == .member) {
                    cell.detailTextLabel?.text = String(eventMember.value)
                }
                return cell
            }
            break
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = dataSource[indexPath.section][indexPath.row]
        switch row {
        case .place:
            if let viewController = R.storyboard.findLocation.instantiateInitialViewController() {
                if let rootViewController = viewController.viewControllers.first as? FindLocationViewController {
                    //rootViewController.event = event.value
                }
                present(viewController, animated: true, completion: nil)
            }
            break
        case .date:
            DatePickerDialog.show(defaultDate: Date(), datePickerMode: .dateAndTime) { (date) in
                self.eventDate.value = date!
            }
            break
        case .member:
            let memberCount = ["2", "4", "6", "8", "10"];
            PickerDialog.show(dataSource: memberCount) { (member) in
                self.eventMember.value = Int(member) ?? 0
            }
            break
        default:
            break
        }
    }
}
