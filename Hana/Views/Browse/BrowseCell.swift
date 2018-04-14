//
//  BrowseCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/28.
//

import UIKit

let cellIdentifiler = "BrowseCell"

protocol BrowseCellDelegate: class {
    func didTouchProfileImage(with Object: UserInfo?)
    func didTouchLiked(with Object: UserInfo?)
}

class BrowseCell: UICollectionViewCell {

    weak var delegate: BrowseCellDelegate?
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
        if let guardDelegate = delegate {
            guardDelegate.didTouchLiked(with: userInfo)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ((event?.touches(for: profileImageView)) != nil) {
            if let guardDelegate = delegate {
                guardDelegate.didTouchProfileImage(with: userInfo)
            }
        }
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
