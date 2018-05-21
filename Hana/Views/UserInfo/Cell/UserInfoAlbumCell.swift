//
//  UserInfoAlbumCell.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/21.
//

import UIKit

enum AlbumShowMode: Int {
    case horizontal
    case vertical
}

class UserInfoAlbumCell: UITableViewCell {

    fileprivate let collectionCellIdentifier = R.reuseIdentifier.userInfoAlbumItemCell.identifier
    @IBOutlet weak var collectionView: UICollectionView!
    private var albums: [String]!
    
    static func height(with mode: AlbumShowMode, dataSource: UserInfo) -> CGFloat {
        let itemSize = UserInfoAlbumItemCell.size(with: mode)
        if let albums = dataSource.albums {
            switch mode {
            case .horizontal:
                return (itemSize.height + UserInfoAlbumItemCell.spacing) * CGFloat(albums.count)
            case .vertical:
                return (itemSize.height + UserInfoAlbumItemCell.spacing) * CGFloat(albums.count)/2
            }
        }
        return 0.0
    }
    
    func reload(with mode: AlbumShowMode, dataSource: UserInfo) {
        albums = dataSource.albums ?? []
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = UserInfoAlbumItemCell.spacing
        layout.minimumInteritemSpacing = UserInfoAlbumItemCell.spacing
        layout.itemSize = UserInfoAlbumItemCell.size(with: mode)
        collectionView.reloadData()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(R.nib.userInfoAlbumItemCell(), forCellWithReuseIdentifier: collectionCellIdentifier)
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension UserInfoAlbumCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as? UserInfoAlbumItemCell {
            cell.albumImageView.sd_setImage(with: URL(string: albums[indexPath.row]), placeholderImage: nil)
            return cell
        }
        return UICollectionViewCell()
    }
    
}
