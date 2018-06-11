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

        setupLayout()
        loadRemoteData()
    }

    fileprivate func setupLayout() {
        setNavigationBarBackIndicatorImage(R.image.icon_back()!)
        // Register cell classes
        self.collectionView?.register(R.nib.browseCell(), forCellWithReuseIdentifier: reuseIdentifier)

        let layout = self.collectionView.collectionViewLayout as! WaterFallViewLayout
        layout.delegate = self
        //        layout.itemSize = BrowseCell.itemSize
//        layout.minimumLineSpacing = BrowseCell.spacing
//        layout.sectionInset = BrowseCell.edgeInsets

    }

    func loadRemoteData() {
        UserInfoDao.findAll  { (objects, isSuccess) in
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

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, WaterFallViewLayoutDelegate
extension BrowseViewController: UICollectionViewDelegate, UICollectionViewDataSource, WaterFallViewLayoutDelegate {
    func waterFallViewLayout(layout: WaterFallViewLayout, heightForItemAt item: Int) -> CGFloat {
        if (item + 1) % 2 == 0 {
            return BrowseCell.itemSmallHeight
        }
        return BrowseCell.itemLargeHeight
    }

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
            cell.model = dataSource?[indexPath.row]
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let viewController = R.storyboard.userInfo.userInfoViewController() {
            viewController.userInfo = dataSource![indexPath.row]
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: - BrowseCellDelegate
extension BrowseViewController: BrowseCellDelegate {
    
    func browseCell(_ cell: BrowseCell, didTouchLikeAt model: UserInfo!) {
        LikeDao.findLiked(by: model) { (like, isSuccess) in
            if like == nil {
                let like = Like(with: model)
                like.saveInBackground { (isSuccess, error) in
                    ParseHelper.sendPush(with: like, completion: nil)
                }
            }
            like?.matched = true

            like?.saveInBackground(block: { (isSuccess, error) in
                ParseHelper.sendPush(with: like!, completion: nil)
            })
        }
        
        if let indexPath = collectionView.indexPath(for: cell) {
            dataSource?.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
    }
    
    func browseCell(_ cell: BrowseCell, didTouchDislikeAt model: UserInfo!) {
        if let indexPath = collectionView.indexPath(for: cell) {
            dataSource?.remove(at: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
        }
    }
}


