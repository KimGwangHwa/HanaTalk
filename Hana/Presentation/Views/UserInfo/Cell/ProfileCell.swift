//
//  ProfileCell.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/08.
//

import UIKit

protocol ProfileCellDelegate: class {
    func didChangedDisplay(to mode: AlbumDisplayMode)
    func didTouchAddAlbum()
}

class ProfileCell: UITableViewCell {
    
    weak var delegate: ProfileCellDelegate?
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    var model: UserInfoEntity! {
        didSet {
            profileImageView.sd_setImage(with: URL(string: model.profileUrl ?? ""), placeholderImage: R.image.icon_profile())
            nickNameLabel.text = model.nickname
            bioLabel.text = model.bio
            infoLabel.text = "\(model.birthday?.string(format: .date) ?? "" ) | \(model.sex.name)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    @IBAction func tappedHorizontal(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didChangedDisplay(to: .horizontal)
        }
    }
    
    @IBAction func tappedVertica(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didChangedDisplay(to: .vertical)
        }
    }
    
    @IBAction func tappedAddAlbum(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didTouchAddAlbum()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func eventButtonEvent(_ sender: UIButton) {
        
    }
}
