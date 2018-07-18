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
       
    @IBOutlet weak var rightBarButton: UIButton!
    
    let nameCellIdentifier = R.reuseIdentifier.createEventNameCell.identifier
    let normalCellIdentifier = R.reuseIdentifier.createEventNormalCell.identifier
    let detaillCellIdentifier = R.reuseIdentifier.createEventDetailCell.identifier
    
    var dataSource = [[EventRow.name, EventRow.detail],[EventRow.date, EventRow.place, EventRow.member]];
    
    var usecase: EventUseCase! = nil
    
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

        usecase.addModelObserver {
            self.didInputChanged()
        }
        
    }
    
    @IBAction func tappedCreat(_ sender: UIButton) {
        
        usecase.create { (isSuccess) in
            if isSuccess {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tappedCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK - DidInputChanged
    
    func didInputChanged() {
        if !usecase.model.isEmpty {
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
                _ = cell.textField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.name)
                return cell
            }
            break
        case .detail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: detaillCellIdentifier, for: indexPath) as? CreateEventDetailCell {
                cell.placeholder = row.rawValue
                _ = cell.textView.rx.text.map { $0 ?? "" }.bind(to: usecase.model.detail)
                return cell
            }
            break
        case .date, .place, .member:
            if let cell = tableView.dequeueReusableCell(withIdentifier: normalCellIdentifier, for: indexPath) as? CreateEventNormalCell {
                cell.textLabel?.text = row.rawValue
                if row == .date {
                    _ = usecase.model.date.asObservable().bind(to: cell.detailTextLabel!.rx.text)
                } else if (row == .place) {
                    _ = usecase.model.placeText.asObservable().bind(to: cell.detailTextLabel!.rx.text)
                } else if (row == .member) {
                    _ = usecase.model.member.asObservable().bind(to: cell.detailTextLabel!.rx.text)
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
            DatePickerDialog.show(defaultDate: usecase.model.date.value.date(format: .dateAndTime) ?? Date()) { (date) in
                self.usecase.model.date.value = date.string(format: .dateAndTime)
            }

            break
        case .member:
            PickerDialog.show(defaultText: usecase.model.member.value, dataSource: usecase.memberCount) { (stringCount) in
                self.usecase.model.member.value = stringCount
            }

            break
        default:
            break
        }
    }
}

extension CreateEventViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return usecase.memberCount.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return usecase.memberCount[row]
    }
}
