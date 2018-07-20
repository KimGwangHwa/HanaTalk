//
//  EventCell.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/12.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventPlaceLabel: UILabel!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventMemberCountLabel: UILabel!
    
    var model: EventModel! {
        didSet {
            eventImageView.sd_setImage(with: URL(string: model.organizer.profileUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholderImage"))
            eventMemberCountLabel.text = String(model.members?.count ?? 0)
            bgImageView.sd_setImage(with: URL(string: model.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholderImage"))
            eventNameLabel.text = model.rxName.value
            eventDateLabel.text = model.date.string(format: .full)
            eventPlaceLabel.text = model.rxPlace.value.address
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
