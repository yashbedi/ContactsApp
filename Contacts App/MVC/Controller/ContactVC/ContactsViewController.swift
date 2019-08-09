//
//  ContactsViewController.swift
//  Contacts App
//
//  Created by Yash Bedi on 06/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactsViewController: BaseViewController {
    
    //MARK: Pubilc Properties
    
    internal var contactsList = [String:[Contact]]()
    internal var wordsSection = [String]()
    
    //MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts"

        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(UINib(nibName: Constants.kContactsCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactsCell)
        
        let rightButton = UIBarButtonItem.init(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButton)
        )
        
        let leftButton = UIBarButtonItem.init(
            title: "Groups",
            style: .plain,
            target: nil,
            action: nil
        )
        
        let darkMode = UIBarButtonItem.init(
            title: "🛸",
            style: .plain,
            target: self,
            action: #selector(toggleDarkMode)
        )
        
        navigationItem.rightBarButtonItems = [rightButton,darkMode]
        navigationItem.leftBarButtonItem = leftButton
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3144376874, green: 0.8898145556, blue: 0.7598797679, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheme), name: NSNotification.Name("ThemeChanged"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.fetchContacts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @objc fileprivate func addButton(){
        let contactEditVC = ContactEditViewController()
        contactEditVC.contactType = .Add
        let navController = UINavigationController(rootViewController: contactEditVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc fileprivate func toggleDarkMode(){
        let theme = ThemeManager.current()
        
        if theme == .Dark {
            ThemeManager.applyTheme(theme: .Light)
        }else{
            ThemeManager.applyTheme(theme: .Dark)
        }
        NotificationCenter.default.post(name: NSNotification.Name("ThemeChanged"), object: nil)
    }
    
    @objc func changeTheme() {
        UIView.animate(withDuration: 0.9, animations: {
            self.view.backgroundColor = ThemeManager.current().background
            self.tableView?.separatorColor = ThemeManager.current().grey
            
            self.tableView?.reloadData()
            self.navigationController?.navigationBar.barTintColor = ThemeManager.current().fillColor
            self.navigationController?.navigationBar.tintColor =  #colorLiteral(red: 0.3459968596, green: 1, blue: 0.8583579968, alpha: 1)
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : ThemeManager.current().darkGrey]
            self.navigationController?.navigationBar.isTranslucent = false
        }) { (done) in }
    }
    
    
    fileprivate func fetchContacts(){
        contactsList.removeAll()
        wordsSection.removeAll()
        super.showLoading()
        NetworkManager.shared.getContacts { contacts in
            super.hideLoading()
            if contacts != nil{
                for contact in contacts! {
                    if let firstN = contact.firstName {
                        let key = "\(firstN[(firstN.startIndex)])"
                        let upperCased = key.uppercased()
                        if var contactAssociatedToKey = self.contactsList[upperCased] {
                            contactAssociatedToKey.append(contact)
                            self.contactsList[upperCased] = contactAssociatedToKey
                        }else{
                            self.contactsList[upperCased] = [contact]
                        }
                    }
                }
                self.wordsSection = [String](self.contactsList.keys)
                self.wordsSection = self.wordsSection.sorted()
                DispatchQueue.main.async {
                    self.tableView?.reloadData()
                }
            }else{
                self.showAlert(with: Constants.kErrorTitle, and: Constants.kInternetError)
            }
        }
    }
}


