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
            if let imageInData = contact?.image {
                cell.profileImageView.image = UIImage(data: imageInData)
            }
            if (self.contact?.profilePic ?? "").contains("http") {
                if let urlStr = self.contact?.profilePic ,let url = URL(string: urlStr) {
                    NetworkManager.shared.getImage(from: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            cell.profileImageView.image = UIImage(data: data)
                            self.contact?.image = data
                        }
                    }
                }
            }
            cell.nameLabel.text = (contact?.firstName ?? "") + " " + (contact?.lastName ?? "")
            cell.messageButton.addTarget(self, action: #selector(openMessageApp), for: .touchUpInside)
            cell.callButton.addTarget(self, action: #selector(openCallApp), for: .touchUpInside)
            cell.emailButton.addTarget(self, action: #selector(openMailApp), for: .touchUpInside)
            cell.favouriteButton.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
            cell.favouriteButton.setImage(UIImage(named: self.contact?.favourite ?? false ? Constants.kFavIconSelected : Constants.kFavIcon), for: .normal)
            return cell
        case 1:
            // mobile
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            cell.infoLabel.text = Constants.kMobile
            cell.infoField.attributedPlaceholder = NSAttributedString(string: Constants.kMobilePHolder, attributes: [NSAttributedString.Key.foregroundColor : ThemeManager.current().grey.withAlphaComponent(0.6)])
            
            cell.infoField.isUserInteractionEnabled = false
            cell.infoField.text = contact?.mobile ?? ""
            tableView.separatorColor = ThemeManager.current().grey
            return cell
        case 2:
            // email
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            cell.infoLabel.text = Constants.kEmail
            cell.infoField.attributedPlaceholder = NSAttributedString(string: Constants.kEmailPHolder, attributes: [NSAttributedString.Key.foregroundColor : ThemeManager.current().grey.withAlphaComponent(0.6)])
            cell.infoField.isUserInteractionEnabled = false
            cell.infoField.text = contact?.email ?? ""
            tableView.separatorColor = ThemeManager.current().grey
            return cell
        case 3:
            // empty
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactInfoCell, for: indexPath) as! ContactInfoCell
            cell.infoLabel.isHidden = true
            cell.infoField.isHidden = true
            tableView.separatorColor = .clear
            return cell
        case 4:
            // Delete
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kContactDeleteCell, for: indexPath) as! ContactDeleteCell
            tableView.separatorColor = ThemeManager.current().grey
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
                self.showLoading()
                NetworkManager.shared.deleteContact(with: id, completion: { result in
                    self.hideLoading()
                    if result?.compare(Constants.kSuccess) == ComparisonResult.orderedSame{
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }else{
                        self.showAlert(with: Constants.kErrorTitle, and: Constants.kInternetError)
                    }
                })
            }))
            alert.addAction(UIAlertAction(title: Constants.kNo, style: .cancel, handler: { _ in }))
            present(alert, animated: true, completion: nil)
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
    
    internal func getInfoCell(at index: Int) -> ContactInfoCell{
        let cell = tableView?.cellForRow(at: IndexPath(row: index, section: 0)) as! ContactInfoCell
        return cell
    }
}
