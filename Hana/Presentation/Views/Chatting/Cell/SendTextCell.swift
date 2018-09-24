//
//  SendMessageCell.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/28.
//
//

import UIKit
import RxSwift
import RxCocoa

class SendTextCell: UITableViewCell {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var refreshButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with text: String, driver: BehaviorRelay<MessageState>) {
        messageLabel.text = text
        indicatorView.startAnimating()
        _ = driver.asDriver().drive(onNext: { (state) in
            self.indicatorView.stopAnimating()
            self.refreshButton.isHidden = state != .failure
        })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
