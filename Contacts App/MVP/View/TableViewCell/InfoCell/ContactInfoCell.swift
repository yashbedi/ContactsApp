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
    
    internal func setData(from contact: Contact, cellType: CellType){
        switch cellType {
        case .fName:
            infoLabel.text = Constants.kFName
            infoField.attributedPlaceholder = NSAttributedString(string: Constants.kFName, attributes: [NSAttributedString.Key.foregroundColor : ThemeManager.current().grey.withAlphaComponent(0.6)])
            infoField.text = contact.firstName ?? ""
        case .lName:
            infoLabel.text = Constants.kLName
            infoField.attributedPlaceholder = NSAttributedString(string: Constants.kLName, attributes: [NSAttributedString.Key.foregroundColor : ThemeManager.current().grey.withAlphaComponent(0.6)])
            infoField.text = contact.lastName ?? ""
        case .mobile:
            infoLabel.text = Constants.kMobile
            infoField.attributedPlaceholder = NSAttributedString(string: Constants.kMobilePHolder, attributes: [NSAttributedString.Key.foregroundColor : ThemeManager.current().grey.withAlphaComponent(0.6)])
            infoField.text = contact.mobile ?? ""
        case .email:
            infoLabel.text = Constants.kEmail
            infoField.attributedPlaceholder = NSAttributedString(string: Constants.kEmailPHolder, attributes: [NSAttributedString.Key.foregroundColor : ThemeManager.current().grey.withAlphaComponent(0.6)])
            infoField.text = contact.email ?? ""
        default: break
        }
    }
}
