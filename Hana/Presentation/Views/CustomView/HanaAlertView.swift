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
fileprivate let AlertSpacing: CGFloat = 10
fileprivate let AlertHeight: CGFloat = 300

class HanaAlertView: UIView {

    var actionCompletion: ((Like) -> Void)?

    private var overlayView = UIView()
    private var alertView = UIView()

    var object: Like!
    
    
    func setUpView() {
        
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.addSubview(overlayView)
        self.addSubview(alertView)
        
        
        alertView.frame = CGRect(x: AlertSpacing, y: ScreenHeight, width: ScreenWidth - (AlertSpacing*2), height: AlertHeight)
        alertView.cornerRadius = 10


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

        let titleLabel = UILabel(frame: CGRect(x: 0, y: offsetY, width: alertView.width, height: titleHeight))
        if object.matched {
            titleLabel.text = "MATHCED"
        } else {
            titleLabel.text = "LIKED BY"
        }
        titleLabel.font = UIFont.systemFont(ofSize: titleFontSize)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        offsetY += (spaceHeight + titleHeight)
        
        let iconWidth: CGFloat = 100
        let iconHeight: CGFloat = iconWidth

        let iconImageView = UIImageView(frame: CGRect(x: (alertView.width - iconWidth)/2, y: offsetY, width: iconWidth, height: iconHeight))
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconWidth/2
        iconImageView.sd_setImage(with: URL(string: object.likedBy?.profileUrl ?? ""), placeholderImage: nil)
        alertView.addSubview(iconImageView)
       
        offsetY += (spaceHeight + iconHeight)

        let descriptionHeight: CGFloat = 20
        let descriptionFontSize: CGFloat = 16

        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: offsetY, width: alertView.width, height: descriptionHeight))
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = object.likedBy?.nickname
        descriptionLabel.font = UIFont.boldSystemFont(ofSize: descriptionFontSize)
        alertView.addSubview(descriptionLabel)
        
        offsetY += (spaceHeight + descriptionHeight)
        
        let eventButtonWidth: CGFloat = 100
        let eventButtonHeight: CGFloat = 40
        let cornerRadius: CGFloat = 5.0
        let eventButton = UIButton(type: .custom)
        eventButton.frame = CGRect(x: (alertView.width-eventButtonWidth)/2, y: offsetY, width: eventButtonWidth, height: eventButtonHeight)
        
        if object.matched {
            eventButton.setTitle("Message", for: .normal)
        } else {
            eventButton.setTitle("UserInfo", for: .normal)
        }
        
        eventButton.setTitleColor(UIColor.white, for: .normal)
        let backgroundImage = UIImage.colorImage(color: UIColor.red, size: eventButton.size)
        eventButton.setBackgroundImage(backgroundImage, for: .normal)
        eventButton.clipsToBounds = true
        eventButton.layer.cornerRadius = cornerRadius
        eventButton.addTarget(self, action: #selector(tappedEventButton), for: .touchUpInside)
        alertView.addSubview(eventButton)
        
        offsetY += (spaceHeight + eventButtonHeight)

//        alertView.frame = CGRect(x: AlertSpacing, y: ScreenHeight, width: ScreenWidth - (AlertSpacing*2), height: offsetY)

    }
    
    @objc func tapped(_ gestureRecognizer: UITapGestureRecognizer) {
        dismiss()
    }
    
    private func show(in viewController: UIViewController) {
        viewController.view.addSubview(self)
        setUpView()
        UIView.animate(withDuration: ModalAnimateDuration, delay: 0, options: .curveEaseInOut, animations: {
            var frame = self.alertView.frame
            frame.origin.y = ScreenHeight - self.alertView.height - AlertSpacing
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
        actionCompletion!(object)
    }
    
    class func show(in viewController: UIViewController, object: Like, actionCompletion: @escaping (Like?) -> Void) {
        
        let view = HanaAlertView()
        view.actionCompletion = actionCompletion
        view.object = object
        view.show(in: viewController)
    }

}
