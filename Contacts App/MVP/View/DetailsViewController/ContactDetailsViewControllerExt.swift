//
//  ContactDetailsViewControllerExt.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

extension ContactDetailsViewController  : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 5 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactDetailsCell, for: indexPath) as! ContactDetailsCell
            cell.setData(with: self.contact ?? Contact())
            self.contact?.image = cell.profileImageView.image?.pngData()
            return cell
        case 1:
            // mobile
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            cell.infoField.isUserInteractionEnabled = false
            cell.setData(from: self.contact ?? Contact(), cellType: .mobile)
            return cell
        case 2:
            // email
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            cell.infoField.isUserInteractionEnabled = false
            cell.setData(from: self.contact ?? Contact(), cellType: .email)
            return cell
        case 3:
            // empty
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            cell.infoLabel.isHidden = true
            cell.infoField.isHidden = true
            return cell
        case 4:
            // Delete
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactDeleteCell, for: indexPath) as! ContactDeleteCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            guard let id = contact?.id else {return}
            let alert = UIAlertController(title: Constants.kSure, message: Constants.kWantToDelete, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.kYes, style: .destructive, handler: { (action) in
                self.presenter.deleteContact(with: id)
            }))
            alert.addAction(UIAlertAction(title: Constants.kNo, style: .cancel, handler: { _ in }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
        case 0  : return 300
        default : return 56
        }
    }
}
