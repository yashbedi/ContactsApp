//
//  ContactDetailsViewController.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactDetailsViewController: BaseViewController {
    
    // MARK: Private and Public Properties
    
    fileprivate var isFav : Bool = false
    internal var contact: Contact?
    
    // MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        addRightButton()
        getContact()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func tableViewSetup(){
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: Constants.kContactDetailsCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactDetailsCell)
        tableView?.register(UINib(nibName: Constants.kContactInfoCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactInfoCell)
        tableView?.register(UINib(nibName: Constants.kContactDeleteCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactDeleteCell)
    }
    
    private func addRightButton(){
        let rightButton = UIBarButtonItem.init(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButton)
        )
        navigationItem.rightBarButtonItem = rightButton
    }
    
    internal func getContact(){
        guard let id = contact?.id else{
            showAlert(with: Constants.kErrorTitle, and: Constants.kSomethingWent)
            return
        }
        super.showLoading()
        NetworkManager.shared.getContact(from: id) { (contactObject) in
            super.hideLoading()
            if contactObject != nil {
                self.contact = contactObject
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }else{
                self.showAlert(with: Constants.kErrorTitle, and: Constants.kInternetError)
            }
        }
    }
    
    @objc fileprivate func editButton(){
        let contactEditVC = ContactEditViewController()
        contactEditVC.delegate = self
        contactEditVC.contact = self.contact ?? Contact()
        contactEditVC.contactType = .Edit
        let navController = UINavigationController(rootViewController: contactEditVC)
        self.present(navController, animated: true, completion: nil)
    }
}



extension ContactDetailsViewController : ContactDelegate {
    func edit(contact: Contact) {
        self.contact = contact
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}


extension ContactDetailsViewController {
    
    @objc internal func openMessageApp(){
        guard
            let mobileNum = getInfoCell(at: 1).infoField.text, mobileNum.count > 0 else {return}
        let sms: String = "sms:\(mobileNum.removingWhitespaces())&body=\(Constants.kTextMessage)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    @objc internal func openCallApp(){
        guard
            let mobileNum = getInfoCell(at: 1).infoField.text, mobileNum.count > 0 else {return}
        if let url = URL(string: "tel://\(mobileNum.removingWhitespaces())"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc internal func openMailApp(){
        guard
            let email = getInfoCell(at: 2).infoField.text, email.count > 0 else {return}
        let appURL = URL(string: "mailto:\(email)")!
        UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
    }
    
    @objc internal func toggleFavourite(){
        let cell = tableView?.cellForRow(at: IndexPath(row: 0, section: 0)) as! ContactDetailsCell
        isFav = !isFav
        cell.favouriteButton.setImage(UIImage(named: isFav ? Constants.kFavIconSelected : Constants.kFavIcon), for: .normal)
    }
}
