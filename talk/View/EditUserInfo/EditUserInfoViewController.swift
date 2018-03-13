//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit

fileprivate let bioCellIdentifier = R.reuseIdentifier.editBioCell.identifier
fileprivate let profileCellIdentifier = R.reuseIdentifier.editProfileCell.identifier
fileprivate let contactInfoCellIdentifier = R.reuseIdentifier.editContactInfoCell.identifier

class EditUserInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var nicknameTextField: UITextField!
    var mailAddressTextField: UITextField!
    var phoneNumberTextField: UITextField!
    var birthDayTextField: UITextField!
    var sexTextField: UITextField!
    var bioTextView: UITextView!
    
    var profileImage: UIImage?
    let userInfo = DataManager.shared.currentuserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func backButtonEvent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveButtonEvent(_ sender: UIButton) {
        Common.upload(image: profileImage) { (stringUrl) in
            self.userInfo?.profileUrl = stringUrl
            self.userInfo?.nickname = self.nicknameTextField.text
            self.userInfo?.email = self.mailAddressTextField.text
            self.userInfo?.phoneNumber = self.phoneNumberTextField.text
            self.userInfo?.birthday = Common.stringToDate(dateString: self.birthDayTextField.text, format: DATE_FORMAT_1)
            self.userInfo?.bio = self.bioTextView.text
            
            self.userInfo?.saveInBackground(block: { (isSuccess, error) in
                self.userInfo?.pinInBackground()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Table view data source
extension EditUserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? EditProfileCell {
                cell.profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
                cell.delegate = self
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: bioCellIdentifier, for: indexPath) as? EditBioCell {
                cell.textView.text = userInfo?.bio
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: contactInfoCellIdentifier, for: indexPath) as? EditContactInfoCell {
                cell.nicknameTextField.text = userInfo?.nickname
                cell.mailAddressTextField.text  = userInfo?.email
                cell.phoneNumberTextField.text = userInfo?.phoneNumber
                cell.birthDayTextField.text = Common.dateToString(date: userInfo?.birthday, format: DATE_FORMAT_2)
                if let sex = userInfo?.sex {
                    cell.sexTextField.text = sex ? "man" : "women"
                }
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100000
    }
    
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditUserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage = image;
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

// MARK: AlbumViewControllerDelegate
extension EditUserInfoViewController: AlbumViewControllerDelegate {
    func albumViewController(_ viewController: AlbumViewController, didSelect atImage: UIImage?) {
        profileImage = atImage;
    }
}

// MARK: EditProfileCellDelegate
extension EditUserInfoViewController: EditProfileCellDelegate {
    func didTouchChangeProfile() {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            let imageViewController = UIImagePickerController()
            imageViewController.delegate = self
            imageViewController.sourceType = .camera
            self.present(imageViewController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
            if let albumViewController = R.storyboard.album.albumViewController() {
                albumViewController.delegate = self
                self.present(albumViewController, animated: true, completion: nil)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}



