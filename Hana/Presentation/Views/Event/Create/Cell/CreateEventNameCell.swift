//
//  CreateEventNameCell.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/12.
//

import UIKit

class CreateEventNameCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var uploadImageButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func tappedUploadButton(_ sender: UIButton) {
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
