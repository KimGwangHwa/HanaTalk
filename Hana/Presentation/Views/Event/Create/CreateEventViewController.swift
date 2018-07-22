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
    
    var dataSource = [[EventRow.name],[EventRow.date, EventRow.place, EventRow.member], [EventRow.detail]];
    
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
        //tableView.tableHeaderView = UIView()
        usecase.bind {
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
        if !usecase.isEmpty {
            rightBarButton.isEnabled = true
        } else {
            rightBarButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.1
        }
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
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
                _ = cell.textField.rx.text.map { $0 ?? "" }.bind(to: usecase.model.rxName)
                cell.uploadImageButton.rx.controlEvent(UIControlEvents.touchUpInside).subscribe { (e) in
                    UIAlertController.show(in: self, {
                        
                    }, albumHandler: {
                        let imageViewController = UIImagePickerController()
                        imageViewController.delegate = self
                        imageViewController.sourceType = .photoLibrary
                        self.present(imageViewController, animated: true, completion: nil)
                    })
                }.disposed(by: usecase.disposeBag)
                return cell
            }
            break
        case .detail:
            if let cell = tableView.dequeueReusableCell(withIdentifier: detaillCellIdentifier, for: indexPath) as? CreateEventDetailCell {
                cell.placeholder = row.rawValue
                _ = cell.textView.rx.text.map { $0 ?? "" }.bind(to: usecase.model.rxDetail)
                return cell
            }
            break
        case .date, .place, .member:
            if let cell = tableView.dequeueReusableCell(withIdentifier: normalCellIdentifier, for: indexPath) as? CreateEventNormalCell {
                cell.textLabel?.text = row.rawValue
                if row == .date {
                    _ = usecase.model.rxDate.asObservable().bind(to: cell.detailTextLabel!.rx.text)
                } else if (row == .place) {
                    _ = usecase.model.rxPlaceText.asObservable().bind(to: cell.detailTextLabel!.rx.text)
                } else if (row == .member) {
                    _ = usecase.model.rxMember.asObservable().bind(to: cell.detailTextLabel!.rx.text)
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
                    rootViewController.usecase = usecase
                }
                present(viewController, animated: true, completion: nil)
            }
            break
        case .date:
            DatePickerDialog.show(defaultDate: usecase.model.rxDate.value.date(format: .dateAndTime) ?? Date()) { (date) in
                self.usecase.accpet(date: date)
            }

            break
        case .member:
            PickerDialog.show(defaultText: usecase.model.rxMember.value, dataSource: usecase.memberCount) { (stringCount) in
                self.usecase.accpet(member: stringCount)
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

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension CreateEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            usecase.accpet(image: image)
            let imageFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width/2)
            let imageView = UIImageView(frame: imageFrame)
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            tableView.tableHeaderView = imageView
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
