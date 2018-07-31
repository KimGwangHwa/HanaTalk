//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit
import RxCocoa
import RxSwift

fileprivate let editCellIdentifier = R.reuseIdentifier.editUserInfoCell.identifier

class EditUserInfoViewController: UIViewController {
    var usecase = EditUserInfoUseCase()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var nicknameTextField: UITextField!
    var mailAddressTextField: UITextField!
    var phoneNumberTextField: UITextField!
    var birthDayTextField: UITextField!
    var sexTextField: UITextField!
    var bioTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    
    }
    
    func setup() {
        navigationBarColor = BackgroundColor
        tableView.backgroundColor = BackgroundColor
        tableView.register(R.nib.editUserInfoCell(), forCellReuseIdentifier: editCellIdentifier)
        profileImageView.sd_setImage(with: URL(string: usecase.model.profileUrl.value), placeholderImage: R.image.placeholderImage())
        
        if !usecase.model.configured {
            navigationItem.leftBarButtonItem = nil;
        }
    }
    
    func moveToSideMenu() {
        if let appdelegate = UIApplication.shared.delegate as? AppDelegate {
            let sidMenuViewController = SideMenuViewController.shared
            appdelegate.window?.rootViewController = sidMenuViewController
            appdelegate.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func tappedCancel(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func tappedDone(_ sender: UIBarButtonItem) {
        let profileImage = profileImageView.image
//        UploadDao().upload(image: profileImage) { (stringUrl, isSuccess) in
//            self.userInfo.profileUrl = stringUrl
//            self.userInfo.configured = true
//            self.userInfo.saveInBackground(block: { (isSuccess, error) in
//                self.userInfo.pinInBackground()
//                if !self.userInfo.configured {
//                    self.moveToSideMenu()
//                } else {
//                    self.dismiss(animated: true, completion: nil)
//                }
//            })
//        }
    }
    
    @IBAction func tappedChangeProfile(_ sender: UIButton) {
        UIAlertController.show(in: self, {
            let imageViewController = UIImagePickerController()
            imageViewController.delegate = self
            imageViewController.sourceType = .camera
            self.present(imageViewController, animated: true, completion: nil)
        }) {
            let imageViewController = UIImagePickerController()
            imageViewController.delegate = self
            imageViewController.sourceType = .photoLibrary
            self.present(imageViewController, animated: true, completion: nil)
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
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: editCellIdentifier, for: indexPath) as? EditUserInfoCell,
            let infoRow = UserInfoType(rawValue: indexPath.row) {
            cell.nameLabel?.text = infoRow.name
            switch infoRow {
            case .nickname:
                _ = usecase.model.nickname.bind(to: cell.descriptionLabel.rx.text)
                break
            case .birthDay:
                _ = usecase.model.birthDay.bind(to: cell.descriptionLabel.rx.text)
                break
            case .sex:
                _ = usecase.model.sex.bind(to: cell.descriptionLabel.rx.text)
                break
            case .bio:
                _ = usecase.model.bio.bind(to: cell.descriptionLabel.rx.text)
                break
            case .email:
                _ = usecase.model.mail.bind(to: cell.descriptionLabel.rx.text)
                break
            case .phoneNumber:
                _ = usecase.model.tel.bind(to: cell.descriptionLabel.rx.text)
                break
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
                let dataSource = [Sex.female.name, Sex.male.name]
                PickerDialog.show(dataSource: dataSource) { (value) in
                    self.usecase.model.sex.accept(value)
                }
                return
            case .birthDay:
                let defaultDate = usecase.model.birthDay.value.date(format: .date) ?? Date()
                DatePickerDialog.show(defaultDate: defaultDate) { (date) in
                    self.usecase.model.birthDay.accept(date.string(format: .date))
                }
                return
            default:
                break
            }

            if let viewController = R.storyboard.inputMessage.inputMessageViewController() {
                viewController.userInfoType = infoRow
                viewController.model = usecase.model
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
//extension EditUserInfoViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        tableView.beginUpdates()
//        tableView.endUpdates()
//    }
//}



