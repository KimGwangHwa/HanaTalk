//
//  CustomBadgeView.swift
//  talk
//
//  Created by ひかりちゃん on 2017/09/11.
//
//

import UIKit

class CustomBadgeView: UIImageView {
    
    var badgeString: String? {
        didSet {
            badgeLabel.text = badgeString
        }
    }
    
    var badgeRadius: CGFloat = 5
    
    
    var badgeColor = UIColor.red
    
    private var badgeLabel = BadgeLabel()
    
    override func awakeFromNib() {
        self.clipsToBounds = false
        let diameter = badgeRadius * 2.0
        let offsetX = self.frame.width - diameter
//        let offsetY = self.frame.height - diameter
        badgeLabel.frame = CGRect(x: offsetX, y: 0, width: badgeRadius * 2.0, height: badgeRadius * 2.0 )
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        badgeLabel.text = "12"
        badgeLabel.textColor = UIColor.white
        self.addSubview(badgeLabel)

    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func ma() {
        
        let bounds:CGRect = self.frame;//サイズ
        var center = CGPoint()
        center.x = bounds.origin.x + bounds.size.width / 2.0;
        center.y = bounds.origin.y + bounds.size.height / 2.0;
        let radius = (min(bounds.size.width, bounds.size.height) / 2.0);
        let path:UIBezierPath = UIBezierPath();
        path.addArc(withCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
//        UIColorFromRGB(0xfde9ac).setFill();
//        UIColor
        path.stroke();//枠線
        path.fill();//色
    }
    
}
