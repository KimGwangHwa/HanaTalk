//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit

class EditUserInfoViewController: UITableViewController {

    let showAlbumIdentifier = R.segue.editUserInfoViewController.showAlbum.identifier
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var sexTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var keywordTextField: UITextField!
    
    
    var bioHeight: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        let userInfo = DataManager.shared.currentuserInfo
        profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
        fullNameTextField.text = userInfo?.nickname
        mailTextField.text = userInfo?.email
        phoneNumberTextField.text = userInfo?.phoneNumber
        birthdayTextField.text = Common.dateToString(date: userInfo?.birthday, format: DATE_FORMAT_2)
        sexTextField.text = userInfo?.sex ?? true ? "MAN":"WOMEN"
        //bioTextView.textView.text = userInfo?.bio
//        bioTextView.placeholderAttributedText = NSAttributedString(string: "Bio", attributes: [NSAttributedStringKey.font: self.bioTextView.textView.font!, NSAttributedStringKey.foregroundColor: UIColor.gray])

        keywordTextField.text = userInfo?.keyword
        idLabel.text = userInfo?.objectId
        //tableView.reloadData()
        //tableView.estimatedRowHeight = 10000
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showAlbumIdentifier {
            
            if let navigationViewController = segue.destination as? UINavigationController,
                let viewController = navigationViewController.viewControllers.first as? AlbumViewController {
                viewController.delegate = self
            }
        }
    }
    
    // MARK: Action
    @IBAction func chageProfileButtonEvent(_ sender: UIButton) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            let imageViewController = UIImagePickerController()
            imageViewController.delegate = self
            imageViewController.sourceType = .camera
            self.present(imageViewController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Album", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: self.showAlbumIdentifier, sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeButtonEvent(_ sender: UIButton) {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonEvent(_ sender: UIButton) {
        let userInfo = DataManager.shared.currentuserInfo
        Common.upload(image: profileImageView.image) { (stringUrl) in
            userInfo?.profileUrl = stringUrl
            userInfo?.nickname = self.fullNameTextField.text
            userInfo?.email = self.mailTextField.text
            userInfo?.phoneNumber = self.phoneNumberTextField.text
            userInfo?.birthday = Common.stringToDate(dateString: self.birthdayTextField.text, format: DATE_FORMAT_1)
            userInfo?.bio = self.bioTextView.text
            userInfo?.keyword = self.keywordTextField.text
            
            userInfo?.saveInBackground(block: { (isSuccess, error) in
                userInfo?.pinInBackground()
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return InfoSection.sectionCount
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let enumInfo = InfoSection(rawValue: section) {
            return enumInfo.rowCount(isEditMode: true)
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100000
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView()
        let sectionLabel : UILabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.width, height: 28))
        if let enumInfo = InfoSection(rawValue: section) {
            sectionLabel.text = enumInfo.sectionName
            sectionLabel.backgroundColor = UIColor.white
            sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        }
        sectionHeaderView.addSubview(sectionLabel)
        return sectionHeaderView
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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

// MARK: AlbumViewControllerDelegate
extension EditUserInfoViewController: AlbumViewControllerDelegate {
    func albumViewController(_ viewController: AlbumViewController, didSelect atImage: UIImage?) {
        profileImageView.image = atImage;
    }
}


