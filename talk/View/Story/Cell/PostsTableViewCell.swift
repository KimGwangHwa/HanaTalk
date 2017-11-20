//
//  PostsTableViewCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/13.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var crateDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - IBAction Action

    @IBAction func tapLikedButton(_ sender: UIButton) {
    }
    
    @IBAction func tapCommentButton(_ sender: UIButton) {
    }
}
