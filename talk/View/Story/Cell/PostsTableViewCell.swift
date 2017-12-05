//
//  PostsTableViewCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/13.
//

import UIKit

protocol PostsTableViewCellDelegate {
    func postsTableViewCell(_ cell: PostsTableViewCell, didTapLikedWith object: Posts)
}

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var crateDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    public var displayData: Posts? {
        didSet {
            if let guardDisplayData = displayData {
                if let guardPoster = guardDisplayData.poster {
                    nickNameLabel.text = guardPoster.nickName
                }
                crateDateLabel.text = guardDisplayData.createdAt?.description
                titleLabel.text = guardDisplayData.contents
                
                if let guardImageUrls = guardDisplayData.imageUrls {
                    var offsetX: CGFloat = 0.0
                    let offsetY: CGFloat = 0.0
                    
                    let width = imageScrollView.bounds.size.width
                    let height = imageScrollView.bounds.size.height

                    for imageUrl in guardImageUrls {
                        let imageView = UIImageView(frame: CGRect(x: offsetX, y: offsetY, width: width, height: height))
                        imageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: nil)
                        imageScrollView.addSubview(imageView)
                        offsetX += width
                        imageScrollView.contentSize = CGSize(width: offsetX, height: height)
                    }
                }
            }
        }
    }
    
    // MARK: - IBAction Action

    @IBAction func tapLikedButton(_ sender: UIButton) {
    }
    
    @IBAction func tapCommentButton(_ sender: UIButton) {
    }
}
