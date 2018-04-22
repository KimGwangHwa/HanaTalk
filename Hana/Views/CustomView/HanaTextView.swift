//
//  HanaTextView.swift
//  Hana
//
//  Created by ひかりちゃん on 2018/04/22.
//

import UIKit

protocol HanaTextViewDelegate: class {
    func didChangeHeight(_ height: CGFloat)
}

class HanaTextView: UIScrollView {

    //weak var delegate: HanaTextViewDelegate?
    
    open var textView: HanaInternalTextView {
        return _textView
    }
    
    open var minNumberOfLines: Int {
        get {
            return _minNumberOfLines
        }
        set {
            guard newValue > 1 else {
                _minHeight = simulateHeight(1)
                return
            }
            
            _minHeight = simulateHeight(newValue)
            _minNumberOfLines = newValue
        }
    }
    
    open var maxNumberOfLines: Int {
        get {
            return _maxNumberOfLines
        }
        set {
            guard newValue > 1 else {
                _maxHeight = simulateHeight(1)
                return
            }
            
            _maxHeight = simulateHeight(newValue)
            _maxNumberOfLines = newValue
        }
    }
    
    open var disableAutomaticScrollToBottom = false
    
    open var placeholderAttributedText: NSAttributedString? {
        get { return _textView.placeholderAttributedText }
        set { _textView.placeholderAttributedText = newValue }
    }
    
    open override var inputView: UIView? {
        get {
            return _textView.inputView
        }
        set {
            _textView.inputView = newValue
        }
    }
    
    open override var isFirstResponder: Bool {
        return _textView.isFirstResponder
    }
    
    open override func becomeFirstResponder() -> Bool {
        return _textView.becomeFirstResponder()
    }
    
    open override func resignFirstResponder() -> Bool {
        return _textView.resignFirstResponder()
    }
    
    open override var intrinsicContentSize: CGSize {
        return measureFrame(measureTextViewSize()).size
    }
    
    private let _textView: HanaInternalTextView
    private var _maxNumberOfLines: Int = 0
    private var _minNumberOfLines: Int = 0
    private var _maxHeight: CGFloat = 0
    private var _minHeight: CGFloat = 0
    private var _previousFrame: CGRect = CGRect.zero
    
    // MARK: - Initializers
    
    public override init(frame: CGRect) {
        
        _textView = HanaInternalTextView(frame: CGRect(x: 15, y: 0, width: frame.width - 30, height: frame.height))
        _previousFrame = frame
        
        super.init(frame: frame)
        
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        
        _textView = HanaInternalTextView(frame: CGRect.zero)
        
        super.init(coder: aDecoder)
        
        _textView.frame = CGRect(x: 15, y: 0, width: bounds.width - 30, height: bounds.height)
        _previousFrame = frame
        setup()
    }
    
    // MARK: - Functions
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        guard _previousFrame.width != bounds.width else { return }
        _previousFrame = frame
        fitToScrollView()
    }
    
    // MARK: UIResponder
    
    open override func reloadInputViews() {
        super.reloadInputViews()
        _textView.reloadInputViews()
    }
    
    private func setup() {
        
        _textView.isScrollEnabled = false
        _textView.font = UIFont.systemFont(ofSize: 16)
        _textView.backgroundColor = UIColor.clear
        addSubview(_textView)
        _minHeight = simulateHeight(1)
        maxNumberOfLines = 3
        
        _textView.didChange = { [weak self] in
            self?.fitToScrollView()
        }
        _textView.didUpdateHeightDependencies = { [weak self] in
            self?.updateMinimumAndMaximumHeight()
        }
    }
    
    private func measureTextViewSize() -> CGSize {
        return _textView.sizeThatFits(CGSize(width: self.bounds.width, height: CGFloat.infinity))
    }
    
    private func measureFrame(_ contentSize: CGSize) -> CGRect {
        
        let selfSize: CGSize
        
        if contentSize.height < _minHeight || !_textView.hasText {
            selfSize = CGSize(width: contentSize.width, height: _minHeight)
        } else if _maxHeight > 0 && contentSize.height > _maxHeight {
            selfSize = CGSize(width: contentSize.width, height: _maxHeight)
        } else {
            selfSize = contentSize
        }
        
        var _frame = frame
        _frame.size.height = selfSize.height
        return _frame
    }
    
    private func fitToScrollView() {
        
        let shouldScrollToBottom = contentOffset.y == contentSize.height - frame.height
        let actualTextViewSize = measureTextViewSize()
        let oldScrollViewFrame = frame
        
        var _frame = bounds
        _frame.origin = CGPoint.zero
        _frame.size.height = actualTextViewSize.height
        _textView.frame = _frame
        contentSize = _frame.size
        
        let newScrollViewFrame = measureFrame(actualTextViewSize)
        
        if oldScrollViewFrame.height != newScrollViewFrame.height && newScrollViewFrame.height <= _maxHeight {
            flashScrollIndicators()
        }
        
        frame = newScrollViewFrame
        
        if shouldScrollToBottom {
            scrollToBottom()
        }
        
        invalidateIntrinsicContentSize()
        if delegate != nil {
            //delegate?.didChangeHeight(frame.height)
        }
    }
    
    private func scrollToBottom() {
        guard !disableAutomaticScrollToBottom else { return }
        contentOffset.y = contentSize.height - frame.height
    }
    
    private func updateMinimumAndMaximumHeight() {
        _minHeight = simulateHeight(1)
        _maxHeight = simulateHeight(maxNumberOfLines)
        fitToScrollView()
    }
    
    private func simulateHeight(_ line: Int) -> CGFloat {
        
        let saveText = _textView.text
        var newText = "-"
        
        _textView.isHidden = true
        
        for _ in 0..<line-1 {
            newText += "\n|W|"
        }
        
        _textView.text = newText
        
        let height = measureTextViewSize().height
        
        _textView.text = saveText
        _textView.isHidden = false
        
        return height
    }

}
