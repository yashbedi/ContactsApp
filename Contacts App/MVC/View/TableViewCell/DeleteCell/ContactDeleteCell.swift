//
//  ContactDeleteCell.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactDeleteCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var deleteLabel: UILabel!
    
    // MARK: View Life cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = ThemeManager.current().fillColor
    }
}
