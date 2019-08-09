//
//  ContactsViewControllerExt.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

extension ContactsViewController  : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.wordsSection.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.wordsSection[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = wordsSection[section]
        if let values = contactsList[key] {
            return values.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! ContactsCell
        let key = wordsSection[indexPath.section]
        if let value = contactsList[key] {
            cell.nameLabel.text = "\(value[indexPath.row].firstName ?? "") \(value[indexPath.row].lastName ?? "")"
            cell.favouriteImageView.isHidden = !value[indexPath.row].favourite
            if (value[indexPath.row].profilePic ?? "").contains("http") {
                if let urlStr = value[indexPath.row].profilePic ,let url = URL(string: urlStr) {
                    NetworkManager.shared.getImage(from: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async() {
                            cell.profileImageView.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contactDetails = ContactDetailsViewController()
        let key = wordsSection[indexPath.section]
        if let value = contactsList[key] {
            contactDetails.contact = value[indexPath.row]
        }
        self.navigationController?.pushViewController(contactDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return wordsSection
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.backgroundView?.backgroundColor = ThemeManager.current().shadow
    }
}
