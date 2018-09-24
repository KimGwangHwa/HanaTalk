//
//  MatchingCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit

class MatchingCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    private var closure: (ChatModel)-> Void = {_ in }
    private var models: [ChatModel]!

    func config(with models: [ChatModel], closure: @escaping (ChatModel)-> Void ) {
        self.closure = closure
        self.models = models
        collectionView.reloadData()
    }
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
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? MatchingStatusCell {
            cell.model  = models[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        closure(models[indexPath.row])
    }
    
}
