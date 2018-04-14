//
//  MatchingCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit

class MatchingCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource: [Message]?
    let itemCellIdentifier = R.reuseIdentifier.matchingStatusCell.identifier
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.matchingStatusCell(), forCellWithReuseIdentifier: itemCellIdentifier)

        loadData()
    }
    
    func loadData() {
        MessageDao.findBeLikedMessages { (messages) in
            self.dataSource = messages
            self.collectionView.reloadData()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MatchingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? MatchingStatusCell {
            cell.backgroundColor = UIColor.red
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
