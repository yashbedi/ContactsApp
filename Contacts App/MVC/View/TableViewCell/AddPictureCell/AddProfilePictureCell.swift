//
//  AddProfilePictureCell.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class AddProfilePictureCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var openSourceButton: UIButton!
    @IBOutlet weak var bgView: GradientView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    // MARK: View Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        profileImageView.alpha = 0
        profileImageView.contentMode = .scaleAspectFill
        bgView.startColor = ThemeManager.current().background
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.3) {
            self.profileImageView.alpha = 1
        }
    }
}
