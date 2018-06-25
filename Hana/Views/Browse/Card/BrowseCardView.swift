//
//  BrowseCardView.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/24.
//

import UIKit

class BrowseCardView: UIView {

    let cellIdentifierr = R.reuseIdentifier.browseCell.identifier
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model: UserInfo! {
        didSet {

            collectionView.reloadData()
        }
    }
    
    var isConfiged: Bool = false
    
    
    override func layoutSubviews() {
        if isConfiged == false {
            if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                layout.itemSize = frame.size
                layout.sectionInset = UIEdgeInsets.zero
                layout.minimumLineSpacing = 0
                layout.minimumInteritemSpacing = 0
            }
            isConfiged = true
        }
        
    }
    
    override func awakeFromNib() {
        layer.shouldRasterize = true;
        layer.rasterizationScale = UIScreen.main.scale;
        collectionView.register(R.nib.browseCell(), forCellWithReuseIdentifier: cellIdentifierr)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension BrowseCardView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.albums?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifierr, for: indexPath) as? BrowseCell {
            cell.imageUrl = model.albums == nil ? model.profileUrl :  model.albums?[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
}
