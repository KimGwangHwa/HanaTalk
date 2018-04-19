//
//  BrowseViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/28.
//

import UIKit

private let reuseIdentifier = R.reuseIdentifier.browseCell.identifier

class BrowseViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [UserInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false


        setupLayout()
        loadRemoteData()
    }

    fileprivate func setupLayout() {
        
        // Register cell classes
        self.collectionView?.register(R.nib.browseCell(), forCellWithReuseIdentifier: reuseIdentifier)

        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = BrowseCell.itemSize
    }

    func loadRemoteData() {
        UserInfo.findAll  { (objects, isSuccess) in
            self.dataSource = objects
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func sideMenuButtonEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = dataSource?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? BrowseCell {
            cell.userInfo = dataSource?[indexPath.row]
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()

    }
}

// MARK: - BrowseCellDelegate
extension BrowseViewController: BrowseCellDelegate {
    
    func didTouchProfileImage(with Object: UserInfo?) {
        if let userInfoViewController = R.storyboard.userInfo.userInfoViewController() {
            userInfoViewController.userInfo = Object
            navigationController?.pushViewController(userInfoViewController, animated: true)
        }
    }
    
    func didTouchLiked(with Object: UserInfo?) {
        LikeDao.findLiked(by: Object!) { (like, isSuccess) in
            if like == nil {
                let like = Like(with: Object!)
                like.saveInBackground { (isSuccess, error) in
                    ParseHelper.sendPush(with: like, completion: nil)
                }
            }
            like?.matched = true
            like?.saveInBackground(block: { (isSuccess, error) in
                ParseHelper.sendPush(with: like!, completion: nil)
            })
        }
    }
}


