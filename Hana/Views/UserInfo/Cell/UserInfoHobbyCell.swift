//
//  UserInfoHobbyCell.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/12.
//

import UIKit

class UserInfoHobbyCell: UITableViewCell {
    let hobbyCellId = R.reuseIdentifier.hobbyCell.identifier
    var hobbyDataSource: [String]! = NSArray(contentsOf: R.file.hobbyDataSourcePlist()!) as! [String]

    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.hobbyCell(), forCellWithReuseIdentifier: hobbyCellId)
        collectionView.reloadData()
        layoutIfNeeded()
        collectionHeightConstraint.constant = collectionView.contentSize.height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension UserInfoHobbyCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hobbyDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hobbyCellId, for: indexPath) as? HobbyCell {
            cell.name = hobbyDataSource[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = hobbyDataSource[indexPath.row]
        return text.size(with: 50, font: UIFont.boldSystemFont(ofSize: 16))
    }
    
}
