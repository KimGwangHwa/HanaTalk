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
        return 20.0
    }
    
    static var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
    }
    
    static func size(with mode: AlbumDisplayMode) -> CGSize {
        switch mode {
        case .horizontal:
            let width: CGFloat = UIScreen.main.bounds.width - (spacing*2)
            return CGSize(width: width, height: width)
        case .vertical:
            let width: CGFloat = (UIScreen.main.bounds.width - (spacing*3))/2
            return CGSize(width: width, height: width)
        }
    }
}
