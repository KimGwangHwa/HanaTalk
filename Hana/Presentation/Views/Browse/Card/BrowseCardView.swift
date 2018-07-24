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
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var pageControl: HNPageControl!
    
    var model: UserInfoEntity! {
        didSet {
            infoLabel.text = "\(model.nickname ?? "")" + "，" + "\(String(model.birthday?.age ?? 0))"
            pageControl.numberOfPages = model.albums?.count ?? 1
        }
    }
    
    override func awakeFromNib() {
        collectionView.register(R.nib.browseCell(), forCellWithReuseIdentifier: cellIdentifierr)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func draw(_ rect: CGRect) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = collectionView.size
            layout.sectionInset = UIEdgeInsets.zero
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
        collectionView.reloadData()
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
