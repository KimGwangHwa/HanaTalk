//
//  UserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/11.
//

import UIKit

fileprivate let profileCellIdentifier = R.reuseIdentifier.profileCell.identifier
fileprivate let albumCellIdentifier = R.reuseIdentifier.userInfoAlbumCell.identifier

class UserInfoViewController: UIViewController {

    let usecase = UserInfoUseCase()
    var displayMode: AlbumDisplayMode = .vertical
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadRomoteData()
    }
    
    func setUpView() {
        navigationBarBackgroundImageIsHidden = true
        navigationBarColor = BackgroundColor
        // if is self
        if usecase.isSelf {
            let leftButton = UIButton(type: .custom)
            leftButton.setImage(R.image.icon_menu(), for: .normal)
            leftButton.addTarget(self, action: #selector(tappedMenu(_:)), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        }
        let rightButton = UIButton(type: .custom)
        rightButton.setImage(R.image.icon_more(), for: .normal)
        rightButton.addTarget(self, action: #selector(tappedMore), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        tableView.backgroundColor = BackgroundColor
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(R.nib.profileCell(), forCellReuseIdentifier: profileCellIdentifier)
        tableView.register(R.nib.userInfoAlbumCell(), forCellReuseIdentifier: albumCellIdentifier)

    }
    
    @objc func tappedMore() {
        
        let alert = UIAlertController()
        
        if usecase.isSelf {
            alert.addAction(UIAlertAction(title: "edit profile", style: .default, handler: { (action) in
                self.moveEdit()
            }))
        } else {
            alert.addAction(UIAlertAction(title: "❤️", style: .default, handler: { (action) in
                
            }))
            alert.addAction(UIAlertAction(title: "✖️", style: .default, handler: { (action) in
                
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func moveEdit() {
        if let viewController = R.storyboard.editUserInfo.instantiateInitialViewController(),
            let editViewController = viewController.viewControllers.first as? EditUserInfoViewController {
            editViewController.usecase = usecase
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    func loadRomoteData() {
        usecase.read { (isSuccess) in
            self.navigationItem.title = self.usecase.model.name
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: TextColor]
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func tappedMenu(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: profileCellIdentifier, for: indexPath) as? ProfileCell {
                cell.model = usecase.model
                cell.delegate = self
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: albumCellIdentifier, for: indexPath) as? UserInfoAlbumCell {
                cell.reload(with: displayMode, dataSource: usecase.model)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard usecase.model != nil else {
            return 0
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return UserInfoAlbumCell.height(with: displayMode, dataSource: usecase.model)
        }
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 3 {
            if let viewController = R.storyboard.hobbySelection.hobbySelectionViewController() {
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
}

// MARK: - ProfileCellDelegate
extension UserInfoViewController: ProfileCellDelegate {
    
    func didChangedDisplay(to mode: AlbumDisplayMode) {
        displayMode = mode
        tableView.reloadData()
    }
    
    func didTouchAddAlbum() {
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
}

// MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension UserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            usecase.upload(album: image) { (isSuccess) in
                self.loadRomoteData()
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

