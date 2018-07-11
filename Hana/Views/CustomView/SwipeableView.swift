//
//  SwipeableView.swift
//  Test
//
//  Created by kimgwanghwa on 2018/06/21.
//  Copyright © 2018年 kimgwanghwa. All rights reserved.
//

import UIKit

let DragCompleteRatio: CGFloat = 0.8
let SecondCardScale: CGFloat = 0.95
let MaxCardCount = 50

enum DraggableDirection {
    case none
    case left
    case right
}

protocol SwipeableViewDataSource: class {
    func numberOfRow() -> Int
}

protocol SwipeableViewDelegate: class {
    func swipeableView(_ swipeableView: SwipeableView, displayViewForRowAt index: Int) -> UIView
    func swipeableView(_ swipeableView: SwipeableView, didSelectRowAt index: Int)
}


class SwipeableView: UIView {

    weak var dataSource: SwipeableViewDataSource? {
        didSet {
            setup()
        }
    }
    weak var delegate: SwipeableViewDelegate?
    
    var direction: DraggableDirection = .none
    
    var leftSwipingImage: UIImage?
    var rightSwipingImage: UIImage?

    private var topView: UIView! {
        return subviews.last!
    }
    
    private var topCenter: CGPoint!
    
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
    private var isConfigured: Bool = false
    
    private var swipingImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        setup()
    }
    
    override func layoutSubviews() {
        if isConfigured == false {
            updateSubviewFrame()
            isConfigured = true
        }
    }
    
    func reloadData() {
        setup()
    }
    
    func setup() {

        if rowCount == 0 {
            return
        }
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        
        if let delegate = delegate {
            for index in 1...rowCount {
                let cardView = delegate.swipeableView(self, displayViewForRowAt: rowCount - index)
                cardView.addGestureRecognizer(panGesture)
                cardView.addGestureRecognizer(tapGesture)
                cardView.layer.shouldRasterize = true;
                cardView.layer.rasterizationScale = UIScreen.main.scale;
                addSubview(cardView)
            }
        }
        
        updateSubviewFrame()
        
        initialAnimation()
    }
    
    func updateSubviewFrame() {
        
        let width = self.frame.size.width - edgeInsets.left - edgeInsets.right
        let height = self.frame.size.height - edgeInsets.top - edgeInsets.bottom

        for view in subviews {
            view.transform = CGAffineTransform.identity
            view.frame = CGRect(x: edgeInsets.left, y: edgeInsets.top, width: width, height: height)
            view.setNeedsLayout()
            view.setNeedsUpdateConstraints()
            view.updateConstraintsIfNeeded()
            view.layoutIfNeeded()
            topCenter = view.center
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
        
        guard let gestureView = pan.view else {
            return
        }
        
        let excessRatio = (gestureView.center.x - topCenter.x) / topCenter.x;
        if excessRatio == 0 {
            direction = .none
        } else {
            direction = excessRatio > 0 ? .right : .left
        }
        
        if (pan.state == .changed) {
            
            let point = pan.translation(in: self)
            let movedPoint = CGPoint(x: gestureView.center.x + point.x, y: gestureView.center.y)
            gestureView.center = movedPoint;
            
            
            let rotationAngel = (gestureView.center.x - topCenter.x) / topCenter.x * (CGFloat.pi/20)
            gestureView.transform = CGAffineTransform.init(rotationAngle: rotationAngel)
            if swipingImageView == nil {
                swipingImageView = UIImageView(frame: gestureView.bounds)
                swipingImageView.contentMode = .scaleAspectFit
                gestureView.addSubview(swipingImageView)
            }
            if direction == .left {
                swipingImageView.image = leftSwipingImage
            }
            if direction == .right {
                swipingImageView.image = rightSwipingImage
            }
            swipingImageView.alpha = fabs((gestureView.center.x - topCenter.x) / topCenter.x)

            updateNextScale()

            pan.setTranslation(CGPoint.zero, in: self)
        }
        
        if (pan.state == .ended || pan.state == .cancelled) {
            if fabs(excessRatio) < DragCompleteRatio {
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
                            self.swipingImageView.alpha = 0
                            self.topView.center = self.topCenter
                            self.topView.transform = CGAffineTransform.init(rotationAngle: 0)
            })
            return
            
        }
        
        if direction == .left || direction == .right {
            UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut , .allowUserInteraction], animations: {
                if direction == .left {
                    self.topView.center = CGPoint(x: -1 * self.frame.size.width, y: self.topView.center.y)
                }
                if direction == .right {
                    self.topView.center = CGPoint(x: self.frame.size.width * 2, y: self.topView.center.y)
                }
                let rotationDirection: CGFloat = direction == .left ? -1 : 1;
                self.topView.transform = CGAffineTransform.init(rotationAngle: rotationDirection * CGFloat.pi/4)
                
            }) { (finished) in
                if finished {
                    self.moveToNext()
                }
            }
        }
    }
    
    func moveToNext() {
        
        let topView = subviews.last!;
        topView.removeGestureRecognizer(panGesture)
        topView.removeGestureRecognizer(tapGesture)
        topView.removeFromSuperview()
        
        rowIndex += 1
        
        if let nextView = subviews.last {
            nextView.addGestureRecognizer(panGesture)
            nextView.addGestureRecognizer(tapGesture)
            nextView.transform = CGAffineTransform.identity
            for view in subviews {
                view.isHidden = false
            }
        }
        
        swipingImageView.removeFromSuperview()
        swipingImageView = nil
    }
    
    func updateNextScale() {
        for view in subviews {
            view.isHidden = true
        }
        topView.isHidden = false
        
        if let lastIndex = subviews.index(of: topView) {
            let index = lastIndex - 1
            if subviews.indices.contains(index) {
                let nextView = subviews[index]
                nextView.isHidden = false
                let ratio = fabs((topView.center.x - topCenter.x) / topCenter.x)
                let scale = SecondCardScale + (ratio * (1 - SecondCardScale))
                if scale <= 1 {
                    nextView.transform = CGAffineTransform.init(scaleX: scale, y: scale)
                }
            }
        }
        
    }
    
    func defaultScale(_ view: UIView) {
        if let lastView = self.subviews.first {
            lastView.transform = CGAffineTransform.init(scaleX: SecondCardScale, y: SecondCardScale)
        }
    }
    
    func initialAnimation() {
        
        for view in subviews {
            view.alpha = 0
        }
        
        let currentView = topView!
        currentView.alpha = 1
        currentView.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseInOut, animations: {
            currentView.transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        }) { (isFinish) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                currentView.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
            }) { (isFinish) in
                UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseOut, animations: {
                    currentView.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                }) { (isFinish) in
                    for view in self.subviews {
                        view.alpha = 1
                    }
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveLinear, .allowUserInteraction], animations: {
                        
                    }, completion: nil)
                }
            }
        }

    }
}
