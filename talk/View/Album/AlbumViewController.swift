//
//  AlbumViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/02.
//

import UIKit
import AVFoundation
import Photos

class AlbumViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerPreviewingDelegate, AlbumCellDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = [UIImage]()
    var selectedDictionary = [IndexPath: Int]()
    var selectedCount = 0
    
    
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
        registerForPreviewing(with: self, sourceView: collectionView)

        collectionView.register(R.nib.albumCell(), forCellWithReuseIdentifier: R.reuseIdentifier.albumCell.identifier)
        collectionView.allowsMultipleSelection = true
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 2.5
        let rowCount: CGFloat = 3
        let itemWidth = (UIScreen.main.bounds.size.width - (spacing * (rowCount - 1 ))) / rowCount
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        collectionView.collectionViewLayout = layout

    }
}

// MARK: - Action
extension AlbumViewController {
    
    @IBAction func tapNextButtonEvent(_ sender: UIButton) {
        self.performSegue(withIdentifier: R.segue.albumViewController.showUploadStory.identifier, sender: nil)
    }
    
    @IBAction func tapBackButtonEvent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - CollectionView Delegate
extension AlbumViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumCell.identifier, for: indexPath) as? AlbumCell {
            cell.imageView.image = dataSource[indexPath.row]
            cell.selectedCount = selectedDictionary[indexPath]
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = true
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

// MARK: AlbumCellDelegate
extension AlbumViewController {
    
    func albumCell(_ cell: AlbumCell, didSelectedAlbumImage image: UIImage?, state: Bool) {
        if state == true {
            selectedCount += 1
            if let indexPath = collectionView.indexPath(for: cell) {
                cell.selectedCount = selectedCount
                selectedDictionary[indexPath] = selectedCount
            }
        } else {
            selectedCount -= 1
        }
    }
    
}



