//
//  CreateEventDetailCell.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/12.
//

import UIKit

class CreateEventDetailCell: UITableViewCell {

    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var placeholder: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - UITextViewDelegate
extension CreateEventDetailCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isBlank {
            placeholderLabel.text = placeholder
        } else {
            placeholderLabel.text = nil
        }
    }
    
}
