//
//  EditUserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/22.
//

import UIKit

protocol EditUserInfoViewControllerDelegate: class {
    func editUserInfoViewController(_ viewController: EditUserInfoViewController, didEditingFinish atObject: UserInfo?)
}
class EditUserInfoViewController: UIViewController {
    weak var delegate: EditUserInfoViewControllerDelegate?
    var userInfo: UserInfo?
    var infoCell: EditUserInfoCell?
    
    private let showAlbumIdentifier = R.segue.editUserInfoViewController.showAlbum.identifier
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    
    func setUpView() {
        tableView.register(R.nib.editUserInfoCell(), forCellReuseIdentifier: R.reuseIdentifier.editUserInfoCell.identifier)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    @IBAction func saveButtonEvent(_ sender: UIButton) {
        
        userInfo?.nickName = infoCell?.nickNameTextField.text
        userInfo?.statusMessage = infoCell?.statusTextField.text
        userInfo?.birthday = Common.stringToDate(dateString: infoCell?.birthdayTextField.text, format: DATE_FORMAT_2)
        
        userInfo?.saveInBackground(block: { (isSuccess, error) in
            if isSuccess {
                if self.delegate != nil {
                    self.self.delegate?.editUserInfoViewController(self, didEditingFinish: self.userInfo)
                }
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
}

extension EditUserInfoViewController: AlbumViewControllerDelegate {
    func albumViewController(_ viewController: AlbumViewController, didSelect atImage: UIImage?) {
        userInfo?.profile = Common.imageToFile(atImage)
        self.tableView.reloadData()
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension EditUserInfoViewController: EditUserInfoCellDelegate {
    func editUserInfoCellDidTapEdit() {
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
}


// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension EditUserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userInfo?.profile = Common.imageToFile(image)
            self.tableView.reloadData()
        }
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension EditUserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        infoCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.editUserInfoCell.identifier, for: indexPath) as? EditUserInfoCell
        if let cell = infoCell {
            infoCell = cell
            cell.userInfo = userInfo
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
}
