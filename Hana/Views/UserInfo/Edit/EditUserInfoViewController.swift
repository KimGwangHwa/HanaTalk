//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit


fileprivate let editCellIdentifier = R.reuseIdentifier.editUserInfoCell.identifier

class EditUserInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var nicknameTextField: UITextField!
    var mailAddressTextField: UITextField!
    var phoneNumberTextField: UITextField!
    var birthDayTextField: UITextField!
    var sexTextField: UITextField!
    var bioTextView: UITextView!
    fileprivate var pickerView: UIPickerView!
    fileprivate var datePickerView: UIDatePicker!
    fileprivate let pickerHeight: CGFloat = 162

    let userInfo = DataManager.shared.currentuserInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    
    }
    
    func setup() {
        tableView.register(R.nib.editUserInfoCell(), forCellReuseIdentifier: editCellIdentifier)
        profileImageView.sd_setImage(with: URL(string: userInfo.profileUrl ?? ""), placeholderImage: R.image.icon_profile())
        
        if !userInfo.configured {
            navigationItem.leftBarButtonItem = nil;
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func moveToSideMenu() {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            let sidMenuViewController = SideMenuViewController.shared
            appdelegate.window?.rootViewController = sidMenuViewController
            appdelegate.window?.makeKeyAndVisible()
        }
    }
    
    func showDatePicker() {
        let width = UIScreen.main.bounds.width
        let offsetY = UIScreen.main.bounds.height - pickerHeight

        datePickerView = UIDatePicker(frame: CGRect(x: 0, y: offsetY, width: width, height: pickerHeight))
        datePickerView.addTarget(self, action: #selector(datePickerDidChanged(_:)), for: .valueChanged)
        datePickerView.datePickerMode = .date
        datePickerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(datePickerView)
    }
    
    
    func showPicker() {
        let width = UIScreen.main.bounds.width
        let offsetY = UIScreen.main.bounds.height - pickerHeight

        pickerView = UIPickerView(frame: CGRect(x: 0, y: offsetY, width: width, height: pickerHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(pickerView)
    }
    
    
    func dismissPicker() {
        if pickerView != nil {
            pickerView.removeFromSuperview()
        }
        if datePickerView != nil {
            datePickerView.removeFromSuperview()
        }
    }
    
    @objc func datePickerDidChanged(_ sender: UIDatePicker) {
        userInfo.birthday = sender.date
        tableView.reloadData()
    }
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func tappedDone(_ sender: UIBarButtonItem) {
        let profileImage = profileImageView.image
        UploadDao.upload(image: profileImage) { (stringUrl) in
            self.userInfo.profileUrl = stringUrl
            self.userInfo.configured = true
            self.userInfo.saveInBackground(block: { (isSuccess, error) in
                self.userInfo.pinInBackground()
                if !self.userInfo.configured {
                    self.moveToSideMenu()
                } else {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func tappedChangeProfile(_ sender: UIButton) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            let imageViewController = UIImagePickerController()
            imageViewController.delegate = self
            imageViewController.sourceType = .camera
            self.present(imageViewController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
            let imageViewController = UIImagePickerController()
            imageViewController.delegate = self
            imageViewController.sourceType = .photoLibrary
            self.present(imageViewController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table view data source
extension EditUserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissPicker()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: editCellIdentifier, for: indexPath) as? EditUserInfoCell,
            let infoRow = UserInfoType(rawValue: indexPath.row) {
            cell.nameLabel?.text = infoRow.name
            switch infoRow {
            case .nickname:
                cell.descriptionLabel?.text = userInfo.nickname; break
            case .birthDay:
                cell.descriptionLabel?.text = userInfo.birthday?.string(format: .date); break
            case .sex:
                cell.descriptionLabel?.text = userInfo.sex.name; break
            case .bio:
                cell.descriptionLabel?.text = userInfo.bio; break
            case .email:
                cell.descriptionLabel?.text = userInfo.email; break
            case .phoneNumber:
                cell.descriptionLabel?.text = userInfo.phoneNumber; break
            }
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserInfoType.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let infoRow = UserInfoType(rawValue: indexPath.row)  {
            switch infoRow {
            case .sex:
                showPicker()
                return
            case .birthDay:
                showDatePicker()
                return
            default:
                break
            }

            if let viewController = R.storyboard.inputMessage.inputMessageViewController() {
                viewController.userInfoType = infoRow
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditUserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImageView.image = image;
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: UITextViewDelegate
extension EditUserInfoViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension EditUserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Sex.names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Sex.names[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        userInfo.sex = Sex(name: Sex.names[row])
        tableView.reloadData()
    }
}


