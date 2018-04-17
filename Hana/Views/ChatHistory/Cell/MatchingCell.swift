//
//  MatchingCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit

protocol MatchingCellDelegate: class {

    func matchingCell(_ cell: MatchingCell, didSelectItemAt object: Like)

}

class MatchingCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    weak var delegate: MatchingCellDelegate?
    var dataSource: [Like]! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(R.nib.matchingStatusCell(), forCellWithReuseIdentifier: itemCellIdentifier)
            collectionView.reloadData()
        }
    }
    let itemCellIdentifier = R.reuseIdentifier.matchingStatusCell.identifier
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MatchingCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? MatchingStatusCell {
            cell.model  = dataSource[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.matchingCell(self, didSelectItemAt: dataSource[indexPath.row])
        }
    }
    
}
