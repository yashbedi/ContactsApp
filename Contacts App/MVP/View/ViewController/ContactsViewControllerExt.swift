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
        var numOfSections: Int = 0
        if wordsSection.count > 0 {
            numOfSections            = wordsSection.count
            tableView.backgroundView = nil
        }
        else {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.numberOfLines = 0
            noDataLabel.font          = UIFont.systemFont(ofSize: 25)
            noDataLabel.text          = "No Contacts\nAvailable"
            noDataLabel.textColor     = ThemeManager.current().darkGrey
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
        }
        return numOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.wordsSection[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let values = contactsList[wordsSection[section]] {
            return values.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsCell", for: indexPath) as! ContactsCell
        
        if let value = contactsList[wordsSection[indexPath.section]] {
            cell.nameLabel.text = "\(value[indexPath.row].firstName ?? "") \(value[indexPath.row].lastName ?? "")"
            cell.favouriteImageView.isHidden = !value[indexPath.row].favourite
            
            if let urlStr = value[indexPath.row].profilePic, urlStr.contains("http"),let url = URL(string: urlStr) {
                NetworkManager.shared.getImage(from: url) { _data in
                    DispatchQueue.main.async {
                        cell.profileImageView.image = UIImage(data: _data)
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
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(contactDetails, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 64 }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? { return wordsSection }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let headerView = view as? UITableViewHeaderFooterView else { return }
        headerView.backgroundView?.backgroundColor = ThemeManager.current().shadow
    }
}
