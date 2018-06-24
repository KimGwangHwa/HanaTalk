//
//  SwipeableView.swift
//  Test
//
//  Created by kimgwanghwa on 2018/06/21.
//  Copyright © 2018年 kimgwanghwa. All rights reserved.
//

import UIKit

let DragCompleteRatio: CGFloat = 0.6
let SecondCardScale: CGFloat = 0.98
let ReuseCount: Int = 2

enum DraggableDirection {
    case none
    case left
    case right
}

protocol SwipeableViewDataSource: class {
    func numberOfRow() -> Int
}

protocol SwipeableViewDelegate: class {
    func swipeableView(_ swipeableView: SwipeableView, displayViewForRowAt index: Int) -> UIView?
    func swipeableView(_ swipeableView: SwipeableView, didSelectRowAt index: Int)
}


class SwipeableView: UIView {

    weak var dataSource: SwipeableViewDataSource? {
        didSet {
            setup()
        }
    }
    weak var delegate: SwipeableViewDelegate?
    
    private var direction: DraggableDirection = .none
    
    private var reuseViews = [UIView]()
    
    private var currentView: UIView! {
        return subviews.last!
    }
    
    private var edgeInsets: UIEdgeInsets! = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15) {
        didSet {
            updateSubviewFrame()
        }
    }
    
    private var rowCount: Int {
        if let dataSource = dataSource {
            return dataSource.numberOfRow()
        }
        return 0
    }
    
    private var rowIndex: Int = 0
    
    private var panGesture: UIPanGestureRecognizer!
    private var tapGesture: UITapGestureRecognizer!

    
    private var currentViewCenter: CGPoint!
    private var currentViewFrame: CGRect!
    
    private var isConfigured: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        //setup()
    }
    
    override func layoutSubviews() {
        if isConfigured == false {
            updateSubviewFrame()
            isConfigured = true
        }
    }
    
    func reuseView(of index: Int) -> UIView? {
        if index % ReuseCount == 0 {
            return reuseViews.first
        }
        
        if reuseViews.count >= ReuseCount {
            return reuseViews.last
        }
        
        return nil
    }
    
    func reloadData() {
        setup()
    }
    
    func setup() {

        if rowCount == 0 {
            return
        }
        
        if let delegate = delegate {
            if rowCount >= ReuseCount {
                for index in 0..<ReuseCount {
                    if let subView = delegate.swipeableView(self, displayViewForRowAt: index) {
                        reuseViews.append(subView)
                    }
                }
            }
        }
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        for view in reuseViews.reversed() {
            if let index = reuseViews.index(of: view), index == 0 {
                view.addGestureRecognizer(panGesture)
                view.addGestureRecognizer(tapGesture)
            }
            addSubview(view)
        }
        
        updateSubviewFrame()
        setSecondScale()

    }
    
    func updateSubviewFrame() {
        
        let width = self.frame.size.width - edgeInsets.left - edgeInsets.right
        let height = self.frame.size.height - edgeInsets.top - edgeInsets.bottom
        for view in reuseViews {
            view.transform = CGAffineTransform.identity
            view.frame = CGRect(x: edgeInsets.left, y: edgeInsets.top, width: width, height: height)
        }
        
        if let firstView = reuseViews.first {
            currentViewCenter = firstView.center
            currentViewFrame = firstView.frame
        }
    }
    
    @objc func tap(_ tap: UITapGestureRecognizer) {
        if let delegate = delegate {
            delegate.swipeableView(self, didSelectRowAt: rowIndex)
        }
    }

    @objc func pan(_ pan: UIPanGestureRecognizer) {
        if rowIndex == rowCount {
            return
        }
        
        if (pan.state == .changed) {
            let point = pan.translation(in: self)
            let movedPoint = CGPoint(x: pan.view!.center.x + point.x, y: pan.view!.center.y)
            pan.view?.center = movedPoint;
            
            let rotationAngel = (pan.view!.center.x - currentViewCenter.x) / currentViewCenter.x * (CGFloat.pi/20)
            pan.view?.transform = CGAffineTransform.init(rotationAngle: rotationAngel)
            updateSecondScale()
            
            pan.setTranslation(CGPoint.zero, in: self)
        }
        
        if (pan.state == .ended || pan.state == .cancelled) {
            
            let excessRatio = (pan.view!.center.x - currentViewCenter.x) / currentViewCenter.x;
            if fabs(excessRatio) > DragCompleteRatio {
                direction = excessRatio > 0 ? .right : .left

            } else {
                direction = .none
            }
            
            movePositionWithDirection(direction)

        }
    }
    
    func movePositionWithDirection(_ direction: DraggableDirection) {
        
        if direction == .none {
            UIView.animate(withDuration: 0.55, delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0,
                           options: [.curveEaseOut , .allowUserInteraction],
                           animations: {
                            self.currentView.center = self.currentViewCenter
                            self.currentView.transform = CGAffineTransform.init(rotationAngle: 0)
            })
            return
            
        }
        
        if direction == .left || direction == .right {
            UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut , .allowUserInteraction], animations: {
                if direction == .left {
                    self.currentView.center = CGPoint(x: -1 * self.frame.size.width, y: self.currentView.center.y)
                }
                if direction == .right {
                    self.currentView.center = CGPoint(x: self.frame.size.width * 2, y: self.currentView.center.y)
                }
                let rotationDirection: CGFloat = direction == .left ? -1 : 1;
                self.currentView.transform = CGAffineTransform.init(rotationAngle: rotationDirection * CGFloat.pi/4)
                
            }) { (finished) in
                if finished {
                    self.moveToNext()
                }
            }
        }
    }
    
    func moveToNext() {
        
        rowIndex += 1
        
        currentView.removeGestureRecognizer(panGesture)
        currentView.removeGestureRecognizer(tapGesture)

        if let nextView = reuseView(of: rowIndex) {
            nextView.addGestureRecognizer(panGesture)
            nextView.addGestureRecognizer(tapGesture)

            self.bringSubview(toFront: nextView)
            nextView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }
        
        if let delegate = delegate {
            _ = delegate.swipeableView(self, displayViewForRowAt: rowIndex)
            
            var nextView: UIView? = nil
            if rowIndex + 1 < rowCount {
                nextView = delegate.swipeableView(self, displayViewForRowAt: rowIndex + 1)
            }
            if rowIndex == rowCount - 1 {
                let blankView = UIView(frame: nextView!.bounds)
                blankView.backgroundColor = self.backgroundColor
                nextView!.addSubview(blankView)
            }
        }
        
        updateSubviewFrame()
        setSecondScale()
    }
    
    func updateSecondScale() {
        if let lastView = self.subviews.first {
            let ratio = fabs((currentView.center.x - currentViewCenter.x) / currentViewCenter.x)
            lastView.transform = CGAffineTransform.init(scaleX: SecondCardScale + (ratio * (1 - SecondCardScale)), y: SecondCardScale + (ratio * (1 - SecondCardScale)))
        }
    }
    
    func setSecondScale() {
        if let lastView = self.subviews.first {
            lastView.transform = CGAffineTransform.init(scaleX: SecondCardScale, y: SecondCardScale)
        }
    }
}
