//
//  AlbumViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/02.
//

import UIKit
import AVFoundation
import Photos

protocol AlbumViewControllerDelegate: class {
    func albumViewController(_ viewController: AlbumViewController, didSelect atImage: UIImage?)
}


class AlbumViewController: UIViewController, AlbumCellDelegate {

    weak var delegate: AlbumViewControllerDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var finishButton: UIButton!
    
    var dataSource = [UIImage]()
    var selectedImages = [UIImage]()
    var cellSelectedImage: UIImage?
    
    var photoAssets = [PHAsset]()

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
            manager.requestImageData(for: asset, options: nil, resultHandler: { (data, _, _, _) in
                if let guardImage = UIImage(data: data ?? Data()) {
                    self.dataSource.append(guardImage)
                    self.collectionView.reloadData()
                }
            })
//            manager.requestImage(for: asset, targetSize: CGSize.zero, contentMode: .aspectFit, options: nil, resultHandler: { (image, hashtable) in
//                if let guardImage = image {
//                    self.dataSource.append(guardImage)
//                    self.collectionView.reloadData()
//                }
//            })
        }
    }
    
    func libraryRequestAuthorization() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            case .authorized:
                break
            }
        }
    }
    
    func getAllPhotosInfo() {
        let assets: PHFetchResult = PHAsset.fetchAssets(with: .image, options: nil)
        assets.enumerateObjects({ [weak self] (asset, index, stop) -> Void in
            guard let wself = self else {
                return
            }
            wself.photoAssets.append(asset as PHAsset)
        })
        collectionView.reloadData()
    }
    
    func setUpView() {
        if delegate != nil {
            finishButton.setTitle("OK", for: .normal)
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let guardIdentifier = segue.identifier, guardIdentifier == R.segue.albumViewController.showUploadStory.identifier {
            if let uploadViewController = segue.destination as? UploadStoryViewController {
                uploadViewController.uploadImages = selectedImages
            }
        }
    }

}

// MARK: - Action
extension AlbumViewController {
    
    @IBAction func tapNextButtonEvent(_ sender: UIButton) {
        if delegate != nil {
            dismiss(animated: true, completion: nil)
            delegate?.albumViewController(self, didSelect: cellSelectedImage)
        } else {
            self.performSegue(withIdentifier: R.segue.albumViewController.showUploadStory.identifier, sender: nil)
        }
    }
    
    @IBAction func tapBackButtonEvent(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - CollectionView Delegate
extension AlbumViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerPreviewingDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumCell.identifier, for: indexPath) as? AlbumCell {
            cell.imageView.image = dataSource[indexPath.row]
            if delegate != nil {
                cell.selectedButton.isHidden = true
            } else {
                if let index = selectedImages.index(of: dataSource[indexPath.row]) {
                    cell.selectedCount = index + 1
                }
                cell.delegate = self
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isHighlighted = true
        cellSelectedImage = dataSource[indexPath.row]
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
        guard let selectedImage = image else {
            return
        }
        if state == true {
            if !selectedImages.contains(selectedImage) {
                selectedImages.append(selectedImage)
            }
        } else {
            guard let index = selectedImages.index(of: selectedImage) else {
                return
            }
            selectedImages.remove(at: index)
        }
        collectionView.reloadData()
    }
    
}



