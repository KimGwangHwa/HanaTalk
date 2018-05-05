//
//  HobbySelectionViewController.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/05.
//

import UIKit

class HobbySelectionViewController: UIViewController {
    let hobbyCellId = R.reuseIdentifier.hobbyCell.identifier
    var hobbyDataSource = NSArray(contentsOf: R.file.hobbyDataSourcePlist()!) as! [String]
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        collectionView.register(R.nib.hobbyCell(), forCellWithReuseIdentifier: hobbyCellId)
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HobbySelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
