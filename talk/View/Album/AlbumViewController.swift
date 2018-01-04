//
//  AlbumViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/02.
//

import UIKit
import AVFoundation
import Photos

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerPreviewingDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: options)
        assets.enumerateObjects { (asset, index, stop) in
            let manager: PHImageManager = PHImageManager()
            manager.requestImageData(for: asset, options: nil) { (data, info, orientation, hashtable) in
                if let image = UIImage(data: data!) {
                    self.dataSource.append(image)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    func setUpView() {
        registerForPreviewing(with: self, sourceView: view)

        collectionView.register(R.nib.albumCell(), forCellWithReuseIdentifier: R.reuseIdentifier.albumCell.identifier)
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2.5
        let rowCount: CGFloat = 3
        let itemWidth = (UIScreen.main.bounds.size.width - (spacing * (rowCount - 1 ))) / rowCount
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView.collectionViewLayout = layout

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumCell.identifier, for: indexPath) as? AlbumCell {
            cell.imageView.image = dataSource[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
}

// MARK: 3D Touch
extension AlbumViewController {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let peekPreView = R.storyboard.peek.peekViewController()
        
        if let indexPath = collectionView.indexPathForItem(at: location) {
            peekPreView?.image = dataSource[indexPath.row]
        }
        return peekPreView
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
//        let viewcontroller = UIViewController()
//        viewcontroller.view.backgroundColor = UIColor.blue
//
//        show(viewcontroller, sender: nil)
    }

//    override var previewActionItems: [UIPreviewActionItem] {
//
//        let action1 = UIPreviewAction(title: "Select", style: .default) { (action, viewController) in
//
//        }
//
//        return [action1]
//    }
}

