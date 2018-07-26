//
//  MatchingCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/17.
//

import UIKit
import RxCocoa
import RxSwift

class MatchingCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!

    private var rxTapIndex = BehaviorRelay<Int>(value: 0)
    var tapEventObservable: Observable<Int> {
        return rxTapIndex.asObservable()
    }
    
    var model: [ChatModel]! {
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
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath) as? MatchingStatusCell {
            cell.model  = model[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        rxTapIndex.accept(indexPath.row)
    }
    
}
