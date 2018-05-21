//
//  UserInfoAlbumItemCell.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/21.
//

import UIKit

class UserInfoAlbumItemCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static var spacing: CGFloat {
        return 30.0
    }
    
    static func size(with mode: AlbumShowMode) -> CGSize {
        switch mode {
        case .horizontal:
            let width: CGFloat = UIScreen.main.bounds.width - (spacing*2)
            return CGSize(width: width, height: width)
        case .vertical:
            let width: CGFloat = (UIScreen.main.bounds.width - (spacing*2))/2
            return CGSize(width: width, height: width)
        }
    }
}
