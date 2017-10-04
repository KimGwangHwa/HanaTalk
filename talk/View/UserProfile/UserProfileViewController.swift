//
//  UserProfileViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/28.
//
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = [[R.reuseIdentifier.profileImageCell.identifier, R.reuseIdentifier.nickName.identifier, R.reuseIdentifier.statusCell.identifier,],
                              [R.reuseIdentifier.phoneNumberCell.identifier, R.reuseIdentifier.emailCell.identifier, R.reuseIdentifier.sexCell.identifier, R.reuseIdentifier.birthdayCell.identifier]]
    
    private var albumImage: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - UITableViewDelegate
    
    // Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    // CellForRow
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dataSource[indexPath.section][indexPath.row], for: indexPath)
        
        let cellData =  dataSource[indexPath.section][indexPath.row]

        if let userprofileCell = cell as? UserProfileCell {
            userprofileCell.profileImageView.imageView.sd_setImage(with: URL(string: DataManager.shared.currentUserInfo?.profilePicture ?? ""), placeholderImage: nil)
        }
        
        switch cellData {
        case R.reuseIdentifier.nickName.identifier:
            cell.detailTextLabel?.text = DataManager.shared.currentUserInfo?.nickName
            break
        case R.reuseIdentifier.statusCell.identifier:
            cell.detailTextLabel?.text = DataManager.shared.currentUserInfo?.statusMessage
            break
        case R.reuseIdentifier.phoneNumberCell.identifier:
            cell.detailTextLabel?.text = DataManager.shared.currentUserInfo?.phoneNumber
            break
        case R.reuseIdentifier.emailCell.identifier:
            cell.detailTextLabel?.text = DataManager.shared.currentUserInfo?.email
            break
        case R.reuseIdentifier.sexCell.identifier:
            cell.detailTextLabel?.text = (DataManager.shared.currentUserInfo?.sex ?? true) ? "Man": "Women"
            break
        case R.reuseIdentifier.birthdayCell.identifier:
            cell.detailTextLabel?.text = Common.dateToString(date: DataManager.shared.currentUserInfo?.birthday ?? Date(), format: "yyyMMdd")
            break
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dataSource[indexPath.section][indexPath.row] == R.reuseIdentifier.profileImageCell.identifier {
            return 100
        }
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellData =  dataSource[indexPath.section][indexPath.row]
        
        if cellData == R.reuseIdentifier.profileImageCell.identifier {
            showAlertSheet()
        } else {

            if let infoViewController = R.storyboard.infoInput.infoInputViewController()
            {

                switch cellData {
                case R.reuseIdentifier.nickName.identifier:
                    infoViewController.type = .nickName
                    break
                case R.reuseIdentifier.statusCell.identifier:
                    infoViewController.type = .statusMessage
                    break
                case R.reuseIdentifier.phoneNumberCell.identifier:
                    infoViewController.type = .phoneNumber
                    break
                case R.reuseIdentifier.emailCell.identifier:
                    infoViewController.type = .email
                    break
                case R.reuseIdentifier.sexCell.identifier:
                    infoViewController.type = .sex
                    break
                case R.reuseIdentifier.birthdayCell.identifier:
                    infoViewController.type = .sex
                    break
                default:
                    break
                }
                navigationController?.pushViewController(infoViewController, animated: true)
                
            }
        }
    }
    
    // MARK: - ImagePickerController delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        albumImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        DataManager.shared.currentUserInfo?.uploadProfilePicture(image: albumImage!, completion: { (isSuccess) in
            self.tableView.reloadData()
        })
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - UIAlertController
    
    func showAlertSheet() {
        let alertViewController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertViewController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert) in
            alertViewController.dismiss(animated: true, completion: nil)
        }))
        alertViewController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert) in
            alertViewController.dismiss(animated: true, completion: nil)
            let sourceType: UIImagePickerControllerSourceType = .camera
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                let picker = UIImagePickerController()
                picker.sourceType = sourceType
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }
        }))
        alertViewController.addAction(UIAlertAction(title: "Album", style: .default, handler: { (alert) in
            alertViewController.dismiss(animated: true, completion: nil)
            let sourceType: UIImagePickerControllerSourceType = .savedPhotosAlbum
            if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                let picker = UIImagePickerController()
                picker.sourceType = sourceType
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
            }

        }))
        present(alertViewController, animated: true, completion: nil)
    }
    

}
