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
fileprivate let AlertHeight: CGFloat = 280

fileprivate let MatchingTitle = R.string.localizable.title_Mathing()
fileprivate let buttonTitle = R.string.localizable.send_Message()

class MatchingAlertView: UIView {

    var actionCompletion: (() -> Void)!
    var leftImageUrl: String?
    var rightImageUrl: String?

    private var overlayView = UIView()
    private var alertView = UIView()
    
    func setUpView() {
        
        self.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        self.addSubview(overlayView)
        self.addSubview(alertView)
        
        alertView.frame = CGRect(x: AlertSpacing, y: ScreenHeight, width: ScreenWidth - (AlertSpacing*2), height: AlertHeight)
        alertView.cornerRadius = 10
        alertView.backgroundColor = BackgroundColor

        overlayView.frame = self.bounds
        overlayView.alpha = DismissAlpha
        overlayView.backgroundColor = UIColor.black
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        overlayView.addGestureRecognizer(tap)
        
        alertView.backgroundColor = UIColor.white
        let spaceHeight: CGFloat = 10

        var offsetY: CGFloat = spaceHeight
        let titleHeight: CGFloat = 40
        let titleFontSize: CGFloat = 20

        let titleLabel = UILabel(frame: CGRect(x: 0, y: offsetY, width: alertView.width, height: titleHeight))
        titleLabel.text = MatchingTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleFontSize)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        offsetY += (spaceHeight + titleHeight)

        let imageSize = CGSize(width: 120, height: 120)
        let imageSpacing: CGFloat = 30
        
        let leftImageView = UIImageView(frame: CGRect(x: imageSpacing, y: offsetY, width: imageSize.width, height: imageSize.height))
        leftImageView.cornerRadius = imageSize.width / 2
        leftImageView.sd_setImage(with: URL(string: leftImageUrl ?? ""), placeholderImage: nil)
        leftImageView.contentMode = .scaleAspectFill
        alertView.addSubview(leftImageView)
       
        let rightImageView = UIImageView(frame: CGRect(x: alertView.width - imageSpacing - imageSize.width, y: offsetY, width: imageSize.width, height: imageSize.height))
        rightImageView.cornerRadius = imageSize.width / 2
        rightImageView.sd_setImage(with: URL(string: rightImageUrl ?? ""), placeholderImage: nil)
        rightImageView.contentMode = .scaleAspectFill
        alertView.addSubview(rightImageView)
        
        offsetY += (spaceHeight + imageSize.height)
        
        let eventButtonHeight: CGFloat = 50
        let eventButtonWidth: CGFloat = alertView.width - spaceHeight * 2
        offsetY = alertView.height - eventButtonHeight - spaceHeight

        let okButton = UIButton(type: .custom)
        okButton.frame = CGRect(x: spaceHeight, y: offsetY, width: eventButtonWidth, height: eventButtonHeight)
        okButton.setTitle(buttonTitle, for: .normal)
        okButton.setTitleColor(UIColor.white, for: .normal)
        let backgroundImage = UIImage.colorImage(color: MainColor, size: okButton.size)
        okButton.setBackgroundImage(backgroundImage, for: .normal)
        okButton.cornerRadius = eventButtonHeight/2
        okButton.addTarget(self, action: #selector(tappedEventButton), for: .touchUpInside)
        alertView.addSubview(okButton)
        
        offsetY += (spaceHeight + eventButtonHeight)
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
        actionCompletion()
    }
    
    class func show(in viewController: UIViewController,
                    leftImageUrl: String?,
                    rightImageUrl: String?,
                    actionCompletion: @escaping () -> Void) {
        
        let view = MatchingAlertView()
        view.actionCompletion = actionCompletion
        view.leftImageUrl = leftImageUrl
        view.rightImageUrl = rightImageUrl
        view.show(in: viewController)
    }

}
