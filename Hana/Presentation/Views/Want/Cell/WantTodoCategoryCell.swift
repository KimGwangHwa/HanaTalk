//
//  WantTodoCategoryCell.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/23.
//

import UIKit
import SDWebImage

class WantTodoCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var imageButton: UIButton!
    
    var model: CategoryModel! {
        didSet {
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: URL(string: model.imageUrl), progress: { (_, _, _) in
            
            }, completed: { (image, _, _, _) in
                self.imageButton.setTitle(self.model.name, for: .normal)
                self.imageButton.setImage(image, for: .normal)
                self.imageButton.setImage(image, for: .selected)
                self.imageButton.alignVerticalSpacing = 6
            })
        }
    }
    
    override func awakeFromNib() {
        self.imageButton.imageView?.contentMode = .scaleAspectFit
    }
    
}
