//
//  BrowseCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/28.
//

import UIKit

let cellIdentifiler = "BrowseCell"

protocol BrowseCellDelegate: class {
    func didTouchHeart(_ model: UserInfo!)
    func browseCell(_ cell: BrowseCell, didTouchCloseAt model: UserInfo!)
}

class BrowseCell: UICollectionViewCell {

    weak var delegate: BrowseCellDelegate?
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    static var spacing: CGFloat = 10
    static var edgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }

    static var itemSize: CGSize {
        let width = (UIScreen.main.bounds.width - spacing*3)/2
        return CGSize(width: width, height: width + 44)
    }
    
    var model: UserInfo! {
        didSet {
            infoLabel.text = model.nickname
            profileImageView.sd_setImage(with: URL(string: model.profileUrl ?? ""), placeholderImage: nil)
//            nickNameLabel.text = userInfo?.nickname
//            descriptionLabel.text = userInfo?.email
//            profileImageView.sd_setImage(with: URL(string: userInfo?.profileUrl ?? ""), placeholderImage: nil)
//            let layout = UICollectionViewFlowLayout()
//            layout.itemSize = CGSize(width: collectionView.width, height: collectionView.height)
//            layout.scrollDirection = .horizontal
//            collectionView.collectionViewLayout = layout
//            collectionView.delegate = self
//            collectionView.dataSource = self
//            collectionView.reloadData()
        }
    }
    
    @IBAction func tappedHeart(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didTouchHeart(model)
        }
    }
    
    @IBAction func tappedClose(_ sender: UIButton) {
        if delegate != nil {
            delegate?.browseCell(self, didTouchCloseAt: model)
        }
    }
    
}
