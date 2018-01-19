//
//  UploadStoryImageCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/07.
//

import UIKit

class UploadStoryImageCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    var images: [UIImage]? {
        didSet {
            if let guardImages = images {
                let width = 88
                let height = 88
                var offsetX = 0
                for image in guardImages {
                    let imageView = UIImageView(frame: CGRect(x: offsetX, y: 0, width: width, height: height))
                    imageView.backgroundColor = UIColor.gray
                    imageView.image = image
                    imageView.contentMode = .scaleAspectFit
                    scrollView.addSubview(imageView)
                    offsetX += width
                }
                
                let addButton = UIButton(type: .custom)
                addButton.setTitle("+", for: .normal)
                addButton.frame = CGRect(x: offsetX, y: 0, width: width, height: height)
                scrollView.addSubview(addButton)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
}
