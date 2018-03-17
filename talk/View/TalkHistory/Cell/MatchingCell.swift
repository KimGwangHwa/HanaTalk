//
//  MatchingCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit

class MatchingCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [UserInfo]?
    let itemCellIdentifier = R.reuseIdentifier.matchingStatusCell.identifier
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.matchingStatusCell(), forCellWithReuseIdentifier: itemCellIdentifier)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MatchingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let guardDataSource = dataSource {
//            return guardDataSource.count
//        }
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? MatchingStatusCell {
            cell.backgroundColor = UIColor.red
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
