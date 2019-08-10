//
//  ContactsCell.swift
//  Contacts App
//
//  Created by Yash Bedi on 06/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactsCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: View Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.contentMode = .scaleAspectFill
        backgroundColor = .clear
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = UIImage(named: Constants.kPictureHolder)
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.textColor = ThemeManager.current().darkGrey
    }
}
