//
//  HanaAlertView.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/26.
//

import UIKit

fileprivate let ScreenWidth = UIScreen.main.bounds.width
fileprivate let ScreenHeight = UIScreen.main.bounds.height
fileprivate let ShowAlpha: CGFloat = 0.5
fileprivate let DismissAlpha: CGFloat = 0

class HanaAlertView: UIView {
    
    var actionCompletion: ((_ userInfo: UserInfo?, _ isMatched: Bool) -> Void)?
    var object: UserInfo?
    var message: Message?
    var isMathched = false

    private var overlayView = UIView()
    private var alertView = UIView()
    var title: String?
    var imageURL: String?
    var imageDescription: String?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func setUpView() {
        
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.addSubview(overlayView)
        self.addSubview(alertView)

        overlayView.frame = self.bounds
        overlayView.alpha = DismissAlpha
        overlayView.backgroundColor = UIColor.black
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        overlayView.addGestureRecognizer(tap)
        
        alertView.backgroundColor = UIColor.white
        let spaceHeight: CGFloat = 10

        var offsetY: CGFloat = spaceHeight
        let titleHeight: CGFloat = 20
        let titleFontSize: CGFloat = 16

        let titleLabel = UILabel(frame: CGRect(x: 0, y: offsetY, width: ScreenWidth, height: titleHeight))
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        offsetY += (spaceHeight + titleHeight)
        
        let iconWidth: CGFloat = 100
        let iconHeight: CGFloat = iconWidth

        let iconImageView = UIImageView(frame: CGRect(x: (ScreenWidth - iconWidth)/2, y: offsetY, width: iconWidth, height: iconHeight))
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconWidth/2
        iconImageView.sd_setImage(with: URL(string: imageURL ?? ""), placeholderImage: nil)
        alertView.addSubview(iconImageView)
       
        offsetY += (spaceHeight + iconHeight)

        let descriptionHeight: CGFloat = 20
        let descriptionFontSize: CGFloat = 16

        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: offsetY, width: ScreenWidth, height: descriptionHeight))
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = imageDescription
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: descriptionFontSize)
        alertView.addSubview(descriptionLabel)
        
        offsetY += (spaceHeight + descriptionHeight)
        
        let eventButtonWidth: CGFloat = 100
        let eventButtonHeight: CGFloat = 40
        let cornerRadius: CGFloat = 5.0
        let eventButton = UIButton(type: .custom)
        eventButton.frame = CGRect(x: (ScreenWidth-eventButtonWidth)/2, y: offsetY, width: eventButtonWidth, height: eventButtonHeight)
        
        MessageDao.isMatched(of: object) { (isMathched) in
            self.isMathched = isMathched
            if isMathched {
                eventButton.setTitle("Message", for: .normal)
                self.message?.matched = true
                self.message?.pinInBackground()
            } else {
                eventButton.setTitle("UserInfo", for: .normal)
            }
        }
        
        eventButton.setTitleColor(UIColor.white, for: .normal)
        let backgroundImage = UIImage.colorImage(color: UIColor.red, size: eventButton.size)
        eventButton.setBackgroundImage(backgroundImage, for: .normal)
        eventButton.clipsToBounds = true
        eventButton.layer.cornerRadius = cornerRadius
        eventButton.addTarget(self, action: #selector(tappedEventButton), for: .touchUpInside)
        alertView.addSubview(eventButton)
        
        offsetY += (spaceHeight + eventButtonHeight)

        alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: offsetY)

    }
    
    @objc func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        dismiss()
    }
    
    private func show(in viewController: UIViewController) {
        viewController.view.addSubview(self)
        setUpView()
        UIView.animate(withDuration: ModalAnimateDuration, delay: 0, options: .curveEaseInOut, animations: {
            var frame = self.alertView.frame
            frame.origin.y = ScreenHeight - self.alertView.height
            self.alertView.frame = frame
            self.overlayView.alpha = ShowAlpha
            
        }, completion: nil)
    }
    
    func dismiss() {
        UIView.animate(withDuration: ModalAnimateDuration, delay: 0, options: .curveEaseInOut, animations: {
            var frame = self.alertView.frame
            frame.origin.y = ScreenHeight
            self.alertView.frame = frame
            self.overlayView.alpha = DismissAlpha
        }) { (isFinish) in
            if isFinish == true {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func tappedEventButton() {
        actionCompletion!(object, isMathched)
    }
    
    class func show(in viewController: UIViewController, object: Message?, actionCompletion: @escaping (_ userInfo: UserInfo?, _ isMatched: Bool) -> Void) {
        
        UserInfo.findUserInfo(byObjectId: object?.sender?.objectId) { (userInfo, isSuccess) in
            if isSuccess == true {
                let view = HanaAlertView()
                view.message = object
                view.actionCompletion = actionCompletion
                view.object = userInfo
                view.imageDescription = userInfo?.nickname
                view.imageURL = userInfo?.profileUrl
                view.title = object?.title
                view.show(in: viewController)
            }
        }
    }

}
