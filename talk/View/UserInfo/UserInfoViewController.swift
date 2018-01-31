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


class UserInfoViewController: UICollectionViewController {
    
    var dataSource: [Posts]?
    var userInfo: UserInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        loadRomoteData()
    }
    
    func loadRomoteData() {
        UserInfoApi.findCurrentUserInfo { (response) in
            self.userInfo = response.data
            PostsApi.findPosts(by: self.userInfo?.objectId, completion: { (postsRepsponse) in
                self.dataSource = postsRepsponse.data
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
            if let imageURL = posts?.imageUrls?.first {
                cell.imageView.sd_setImage(with: URL(string: imageURL)
                    , placeholderImage: nil)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as? UserInfoHeaderView {
                header.userinfo = userInfo
                return header;
            }
        }
        return UICollectionReusableView()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
