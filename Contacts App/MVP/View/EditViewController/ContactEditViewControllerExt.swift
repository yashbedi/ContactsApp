//
//  ContactEditViewControllerExt.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

extension ContactEditViewController  : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 5 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kAddProfilePictureCell, for: indexPath) as! AddProfilePictureCell
            if self.contact.image != nil {
                cell.profileImageView.image = UIImage(data: self.contact.image!)
            }
            cell.openSourceButton.addTarget(self, action: #selector(pickProfilePicture), for: .touchUpInside)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            DispatchQueue.main.async {
                cell.infoField.becomeFirstResponder()
            }
            cell.infoField.maxLength = 15
            cell.infoField.isUserInteractionEnabled = true
            
            cell.setData(from: self.contact, cellType: .fName)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            
            cell.infoField.maxLength = 15
            cell.infoField.isUserInteractionEnabled = true
            cell.setData(from: self.contact, cellType: .lName)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            
            cell.infoField.maxLength = 10
            cell.infoField.isUserInteractionEnabled = true
            cell.setData(from: self.contact, cellType: .mobile)
            cell.infoField.keyboardType = .phonePad
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            
            cell.infoField.keyboardType = .emailAddress
            cell.infoField.isUserInteractionEnabled = true
            cell.infoField.maxLength = 25
            
            cell.setData(from: self.contact, cellType: .email)
            return cell
        default :
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0 : return 240
        default: return 56
        }
    }
    
    internal func getInfoCell(at index: Int) -> ContactInfoCell{
        let cell = tableView?.cellForRow(at: IndexPath(row: index, section: 0)) as! ContactInfoCell
        return cell
    }
    
    internal func getImageCell()->AddProfilePictureCell {
        let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as! AddProfilePictureCell
        return cell
    }
    
    @objc internal func pickProfilePicture(){
        ImagePickerManager().pickImage(self) { image in
            let cell = self.getImageCell()
            cell.profileImageView?.image = image
            cell.profileImageView.contentMode = .scaleAspectFill
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height / 2
            cell.profileImageView.layer.masksToBounds = true
            cell.profileImageView.layer.borderWidth = 2
            cell.profileImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
}
