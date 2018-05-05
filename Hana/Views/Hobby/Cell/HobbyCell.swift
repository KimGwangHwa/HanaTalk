//
//  HobbyCell.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/05/05.
//

import UIKit

class HobbyCell: UICollectionViewCell {

    var name: String! {
        didSet {
            hobbyButton.setTitle(name, for: .normal)
        }
    }
    
    @IBOutlet weak var hobbyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
