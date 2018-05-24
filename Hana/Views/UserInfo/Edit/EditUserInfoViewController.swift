//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit


fileprivate enum InfoRow: Int {
    case nickname
    case birthDay
    case sex
    case bio

    case email
    case phoneNumber

    static let count = 6
    
    var name: String {
        
        switch self {
        case .nickname:
            return "nickname"
        case .birthDay:
            return "birthDay"
        case .sex:
            return "sex"
        case .bio:
            return "bio"
        case .email:
            return "email"
        case .phoneNumber:
            return "phoneNumber"
        }
    }
}


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
    
    let userInfo = DataManager.shared.currentuserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(R.nib.editUserInfoCell(), forCellReuseIdentifier: editCellIdentifier)
    }
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func tappedDone(_ sender: UIBarButtonItem) {
        let profileImage = profileImageView.image
        UploadDao.upload(image: profileImage) { (stringUrl) in
            self.userInfo?.profileUrl = stringUrl
            self.userInfo?.nickname = self.nicknameTextField.text
            self.userInfo?.email = self.mailAddressTextField.text
            self.userInfo?.phoneNumber = self.phoneNumberTextField.text
            self.userInfo?.birthday = self.birthDayTextField.text?.date(format: .date)
            self.userInfo?.bio = self.bioTextView.text
            
            self.userInfo?.saveInBackground(block: { (isSuccess, error) in
                self.userInfo?.pinInBackground()
                self.dismiss(animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: editCellIdentifier, for: indexPath) as? EditUserInfoCell,
            let infoRow = InfoRow(rawValue: indexPath.row) {
            cell.nameLabel?.text = infoRow.name
            switch infoRow {
            case .nickname:
                cell.descriptionLabel?.text = userInfo?.nickname; break
            case .birthDay:
                cell.descriptionLabel?.text = userInfo?.birthday?.string(format: .date); break
            case .sex:
                cell.descriptionLabel?.text = userInfo?.sex.toString; break
            case .bio:
                cell.descriptionLabel?.text = userInfo?.bio; break
            case .email:
                cell.descriptionLabel?.text = userInfo?.email; break
            case .phoneNumber:
                cell.descriptionLabel?.text = userInfo?.phoneNumber; break
            }
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return InfoRow.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let infoRow = InfoRow(rawValue: indexPath.row)  {

            var inputType: InputType?
            switch infoRow {
            case .nickname:
                inputType = .text ; break
            case .bio:
                inputType = .longText ; break
            case .email:
                inputType = .email ; break
            case .phoneNumber:
                inputType = .phone ; break
            case .sex:
                return
            case .birthDay:
                return
            }

            if let viewController = R.storyboard.inputMessage.inputMessageViewController() {
                viewController.inputType = inputType!
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


