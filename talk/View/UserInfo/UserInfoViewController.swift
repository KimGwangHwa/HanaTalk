//
//  UserInfoViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/28.
//

import UIKit

private let postsCellReuseIdentifier = R.reuseIdentifier.userInfoPostsCell.identifier
private let headerReuseIdentifier = R.reuseIdentifier.userInfoHeaderView.identifier

private let postsCellNib = R.nib.userInfoPostsCell()
private let collectionHeaderNib = R.nib.userInfoHeaderView()
private let showEditIdentifier = R.segue.userInfoViewController.showEditUserInfo.identifier

class UserInfoViewController: UICollectionViewController {
    
    var dataSource: [Posts]?
    var userInfo: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        loadRomoteData()
    }
    
    func loadRomoteData() {
        UserInfo.findUserInfo(byUserObjectId: DataManager.shared.currentUser?.objectId) { (userInfo, isSuccess) in
            self.userInfo = userInfo
            Posts.findPosts(by: userInfo, completion: { (postsList, isSuccess) in
                self.dataSource = postsList
                self.collectionView?.reloadData()
            })
        }
    }
    
    func setUp() {
        self.collectionView?.register(collectionHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        self.collectionView?.register(postsCellNib, forCellWithReuseIdentifier: postsCellReuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.size.width / 3
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 250)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        self.collectionView?.collectionViewLayout = layout
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let count = dataSource?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postsCellReuseIdentifier, for: indexPath) as? UserInfoPostsCell {
            let posts = dataSource?[indexPath.row]
            if let file = posts?.imageFiles?.first,
                let urlString = file.url {
                cell.imageView.sd_setImage(with: URL(string: urlString)
                    , placeholderImage: nil)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? UserInfoHeaderView {
                header.delegate = self
                header.userinfo = userInfo
                return header;
            }
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showEditIdentifier {
            if let viewController = segue.destination as? EditUserInfoViewController {
                viewController.userInfo = sender as? UserInfo
                viewController.delegate = self
            }
        }
    }
    //MARK: Action
    @IBAction func settingButtonEvent(_ sender: UIButton) {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: showEditIdentifier, sender: self.userInfo);
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Message", style: .default, handler: { (action) in
            
        }))
        alert.addAction(UIAlertAction(title: "Follow", style: .default, handler: { (action) in
            
        }))
        present(alert, animated: true, completion: nil)
    }
    @IBAction func addUserButtonEvent(_ sender: UIButton) {
    }
    
}

// MARK: EditUserInfoViewControllerDelegate
extension UserInfoViewController: EditUserInfoViewControllerDelegate {
    func editUserInfoViewController(_ viewController: EditUserInfoViewController, didEditingFinish atObject: UserInfo?) {
        userInfo = atObject
        collectionView?.reloadData()
    }
}

//MARK: UserInfoHeaderViewDelegate
extension UserInfoViewController: UserInfoHeaderViewDelegate {
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapPosts atObject: UserInfo?) {
      
        
    }
    
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapFollowed atObject: UserInfo?) {
    }
    
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapFollowing atObject: UserInfo?) {
        
    }
    
    func userInfoHeaderView(_ headerView: UserInfoHeaderView, didTapEdit atObject: UserInfo?) {
    }

}
