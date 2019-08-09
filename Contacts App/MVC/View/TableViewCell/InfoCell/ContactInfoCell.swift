//
//  ContactInfoCell.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var infoField: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: View Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        infoField.tintColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 0.51)
        backgroundColor = .clear
        infoField.textColor = ThemeManager.current().darkGrey
        infoLabel.textColor = ThemeManager.current().grey
        infoField.tintColor = ThemeManager.current().grey
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
