//
//  HanaAlertView.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/26.
//

import UIKit

fileprivate let AlertHeight: CGFloat = 200
fileprivate let ScreenWidth = UIScreen.main.bounds.width
fileprivate let ScreenHeight = UIScreen.main.bounds.height
fileprivate let ShowAlpha: CGFloat = 0.5
fileprivate let DismissAlpha: CGFloat = 0

class HanaAlertView: UIView {
    
    private var overlayView = UIView()
    private var alertView = UIView()

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
        
        
        alertView.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: AlertHeight)
        alertView.backgroundColor = UIColor.white
        
    }
    
    @objc func tapped(_ gestureRecognizer: UITapGestureRecognizer) {

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
        
    class func show(in viewController: UIViewController) {
        let view = HanaAlertView()
        view.setUpView()
        
        viewController.view.addSubview(view)
        UIView.animate(withDuration: ModalAnimateDuration, delay: 0, options: .curveEaseInOut, animations: {
            var frame = view.alertView.frame
            frame.origin.y = ScreenHeight - AlertHeight
            view.alertView.frame = frame
            view.overlayView.alpha = ShowAlpha

        }, completion: nil)        
    }

}
