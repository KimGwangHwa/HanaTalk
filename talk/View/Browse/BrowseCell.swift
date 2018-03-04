//
//  BrowseCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/28.
//

import UIKit

let cellIdentifiler = "BrowseCell"

class BrowseCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifiler)
        
    }

    
    static var itemSize: CGSize {
        
        let width = UIScreen.main.bounds.width
        return CGSize(width: width, height: width + 76)
    }
    
    var userInfo: UserInfo? {
        didSet {
            nickNameLabel.text = userInfo?.nickname
            descriptionLabel.text = userInfo?.email
            profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: collectionView.width, height: collectionView.height)
            layout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = layout
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.reloadData()
        }
    }
    
    @IBAction func heartEvent(_ sender: UIButton) {
    }
    
}

extension BrowseCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifiler, for: indexPath)
        return cell
    }
    
}
