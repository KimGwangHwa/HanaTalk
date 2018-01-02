//
//  AlbumViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/02.
//

import UIKit
import AVFoundation
import Photos

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(R.nib.albumCell(), forCellWithReuseIdentifier: R.reuseIdentifier.albumCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.collectionViewLayout = layout
        
        let options = PHFetchOptions()
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
