//
//  WantTodoViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/22.
//

import UIKit

class WantTodoViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let cellIdentifier = R.reuseIdentifier.wantTodoCategoryCell.identifier

    let usecase = CategoryUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadData()
    }
    
    fileprivate func loadData() {
        usecase.read { (models, isSuccess) in
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func setup() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let widht = view.width / 2 - 10
            layout.itemSize = CGSize(width: widht, height: widht)
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension WantTodoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usecase.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WantTodoCategoryCell {
            cell.model = usecase.data![indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WantTodoCategoryHeader", for: indexPath) as? WantTodoCategoryHeader else {
            fatalError("Could not find proper header")
        }
        
        if kind == UICollectionElementKindSectionHeader {
            header.textLabel.text = "section \(indexPath.section)"
            return header
        }
        
        return UICollectionReusableView()
    }
    
}
