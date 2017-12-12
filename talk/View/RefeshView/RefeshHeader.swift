//
//  RefeshHeader.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/10.
//

import UIKit

let RefreshKeyPathContentOffset = "contentOffset"
let RefreshKeyPathContentSize = "contentSize"
let RefreshKeyPathPanState = "state"
let RefreshHeaderHeight: CGFloat = 54.0


class RefeshHeader: UIView {
    var refreshingBlock: RefreshingBlock?
    var pan: UIPanGestureRecognizer?
    weak var scrollView: UIScrollView?

    
    typealias RefreshingBlock = () -> Void

    init(refreshingBlock: @escaping RefreshingBlock) {
        super.init(frame: CGRect.zero)
        self.autoresizingMask = .flexibleWidth
        self.backgroundColor = UIColor.clear
        self.refreshingBlock = refreshingBlock
        self.hn_height = RefreshHeaderHeight
        self.hn_y = -self.hn_height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super .willMove(toSuperview: newSuperview)
        if newSuperview != nil && !(newSuperview is UIScrollView){
            return
        }
        
        self.removeObservers()
        if let  nsuperView = newSuperview{
            self.hn_width = nsuperView.hn_width
            self.hn_x = 0
            self.scrollView = nsuperView as? UIScrollView
//            self.scrollView?.alwaysBounceVertical = true
//            self.scrollViewOriginalInset = (self.scrollView?.contentInset)!
            self.addObservers()
//            self.state = .idle
        }
    }

    //MARK: - KVO
    func addObservers() -> Void {
        self.scrollView?.addObserver(self, forKeyPath: RefreshKeyPathContentOffset, options: [.new, .old], context: nil)
        self.scrollView?.addObserver(self, forKeyPath: RefreshKeyPathContentSize, options: [.new, .old], context: nil)
        self.pan = self.scrollView?.panGestureRecognizer
        self.pan?.addObserver(self, forKeyPath: RefreshKeyPathPanState, options: [.new, .old], context: nil)
    }
    
    func removeObservers() -> Void {
        self.superview?.removeObserver(self, forKeyPath: RefreshKeyPathContentOffset)
        self.superview?.removeObserver(self, forKeyPath: RefreshKeyPathContentSize)
        self.pan?.removeObserver(self, forKeyPath: RefreshKeyPathPanState)
        self.pan = nil
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if !self.isUserInteractionEnabled {
            return
        }
        if let temKeyPath = keyPath  {
            if temKeyPath == RefreshKeyPathContentSize  {
                self.scrollViewContentSizeDidChange(change: change)
            }
            
            if self.isHidden {
                return
            }
            
            if temKeyPath == RefreshKeyPathContentOffset {
                self.scrollViewContentOffsetDidChange(change: change)
                
            }else if temKeyPath == RefreshKeyPathPanState {
                self.scrollViewPanStateDidChange(change: change)
            }
        }
    }
    
    func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
    
    }
    
    func scrollViewPanStateDidChange(change:[NSKeyValueChangeKey : Any]?) -> Void {
        
    }
    func scrollViewContentSizeDidChange(change:[NSKeyValueChangeKey : Any]?) -> Void {
        
    }



//    init(target: Any?, refreshingAction: Selector) {
//        super.init(frame: CGRect.zero)
//        self.set(refreshingTarget: target, action: refreshingAction)
//    }

}
