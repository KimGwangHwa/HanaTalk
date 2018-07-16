//
//  HNAlertView.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/15.
//

import UIKit

fileprivate let ScreenWidth = UIScreen.main.bounds.width
fileprivate let ScreenHeight = UIScreen.main.bounds.height
fileprivate let CompletionHeight: CGFloat = 50.0
fileprivate let ContentHeight: CGFloat = 216.0
fileprivate let CustomSize = CGSize(width: 320, height: ContentHeight + CompletionHeight)

class HNAlertView: UIView {

    private var overlayView = UIView()
    private var effectView: UIVisualEffectView!
    private var customView: UIView?
    private var cancelButton: UIButton!
    private var okButton: UIButton!
    private var title: String!
    private var okTitle: String!
    private var cancelTitle: String!
    private var okComplection: (() -> Void)?
    private var cancelComplection: (() -> Void)?
    
    class func show(with customView: UIView? = nil,
                    title: String = "",
                    okTitle: String = "Done",
                    cancelTitle: String = "Cancel",
                    okComplection: (() -> Void)? = nil,
                    cancelComplection: (() -> Void)? = nil) {
        let view = HNAlertView()
        view.customView = customView
        view.title = title
        view.okTitle = okTitle
        view.cancelTitle = cancelTitle
        view.okComplection = okComplection
        view.cancelComplection = cancelComplection

        view.setUp()
        view.showAnimation()
        UIApplication.shared.keyWindow?.addSubview(view)
    }

    private func setUp() {
        let effect = UIBlurEffect(style: .extraLight)
        effectView = UIVisualEffectView(effect: effect)
        effectView.contentView.backgroundColor = UIColor.white
        effectView.frame = CGRect(origin: CGPoint.zero, size: CustomSize)
        effectView.cornerRadius = 10
        
        okButton = UIButton(type: .system)
        okButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        okButton.setTitle(okTitle, for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle(cancelTitle, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        
        
        
        
        
        overlayView.backgroundColor = UIColor.black
        overlayView.layer.opacity = 0.5

        self.addSubview(overlayView)
        self.addSubview(effectView)
        effectView.contentView .addSubview(okButton)
        effectView.contentView.addSubview(cancelButton)
        
        // Line
        let topLine = UIView(frame: CGRect(x: 0, y: CustomSize.height - CompletionHeight, width: CustomSize.width, height: 0.5))
        topLine.backgroundColor = UIColor.gray
        effectView.contentView.addSubview(topLine)

        let centerLine = UIView(frame: CGRect(x: CustomSize.width/2, y: CustomSize.height - CompletionHeight, width: 0.5, height: CompletionHeight))
        centerLine.backgroundColor = UIColor.gray
        effectView.contentView.addSubview(centerLine)

        // resize
        self.frame = UIScreen.main.bounds
        overlayView.frame = bounds
        cancelButton.frame = CGRect(x: 0, y: ContentHeight, width: CustomSize.width/2, height: CompletionHeight)
        okButton.frame = CGRect(x: CustomSize.width/2, y: ContentHeight, width: CustomSize.width/2, height: CompletionHeight)
        effectView.center = self.center
        
        if let customView = customView {
            effectView.contentView.addSubview(customView)
            customView.frame = CGRect(x: 0, y: 0, width: CustomSize.width, height: ContentHeight)
        }
    }
    
    private func showAnimation() {
        self.effectView.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
        self.effectView.layer.opacity = 0.5
        
        /* Anim */
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.effectView.layer.opacity = 1
                self.effectView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        })
    }
    
    private func dismissAnimation() {
        
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.effectView.layer.opacity = 0.0
                self.effectView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        }) { (isFinish) in
            if isFinish {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func okButtonTapped(){
        if okComplection != nil {
            okComplection!()
        }
        dismissAnimation()
    }
    
    @objc func cancelButtonTapped(){
        if cancelComplection != nil {
            cancelComplection!()
        }
        dismissAnimation()
    }
}
