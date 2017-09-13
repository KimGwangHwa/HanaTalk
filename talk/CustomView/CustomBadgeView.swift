//
//  CustomBadgeView.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/11.
//
//

import UIKit

class CustomBadgeView: UIView {
    
    var imageView = UIImageView()
    
    var badgeLabel = UILabel()
    
    private var badgeView = UIImageView()
    
    
    private let badgeDiameter: CGFloat = 18
    private let badgeFontSize: CGFloat = 13
    
    var badgeString: String? {
        didSet {
            badgeLabel.text = badgeString

            let labelSize = badgeLabel.sizeThatFits(CGSize(width: 100, height: badgeDiameter))
            
            if labelSize.width >= badgeDiameter {
                badgeView.frame.size = labelSize
            } else {
                badgeView.frame.size = CGSize(width: badgeDiameter, height: badgeDiameter)
            }
            badgeLabel.frame.size = badgeView.frame.size

        }
    }
    
    var badgeRadius: CGFloat = 5
    
    
    var badgeColor = UIColor.red
    
    
    override func awakeFromNib() {

        setUpView()

    }
    
    private func setUpView() {
        
        imageView.frame = frame
        imageView.layer.cornerRadius = frame.size.width/2
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 0.2
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        
        badgeView.frame = CGRect(x: frame.size.width - (badgeDiameter/4), y: 0, width: badgeDiameter, height: badgeDiameter)
        badgeView.layer.cornerRadius = badgeDiameter/2
        badgeView.clipsToBounds = true
        badgeView.image = UIImage.colorImage(color: UIColor.red, size: badgeView.frame.size)
        badgeView.addSubview(badgeLabel)
        
        badgeLabel.frame = badgeView.bounds
        badgeLabel.layer.cornerRadius = badgeDiameter/2
        badgeLabel.clipsToBounds = true
        badgeLabel.font = UIFont.systemFont(ofSize: badgeFontSize)
        badgeLabel.textColor = UIColor.white
        badgeLabel.textAlignment = .center

        
        addSubview(imageView)
        addSubview(badgeView)
        
    
    }
    
}
