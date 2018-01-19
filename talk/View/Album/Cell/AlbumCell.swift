//
//  AlbumCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/02.
//

import UIKit
protocol AlbumCellDelegate {
    func albumCell(_ cell: AlbumCell, didSelectedAlbumImage image: UIImage?, state: Bool)
}

class AlbumCell: UICollectionViewCell {
    
    var delegate: AlbumCellDelegate?
    var selectedCount: Int? {
        didSet {
            if let guardCount = selectedCount {
                selectedButton.isSelected = true
                selectedButton.setTitle(String(guardCount), for: .selected)
            } else {
                selectedButton.isSelected = false
                selectedButton.setTitle(nil, for: .selected)
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var selectedButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func selectedButtonEvent(_ sender: UIButton) {
        if (delegate != nil) {
            delegate?.albumCell(self, didSelectedAlbumImage: imageView.image, state: !sender.isSelected)
        }
    }
}
