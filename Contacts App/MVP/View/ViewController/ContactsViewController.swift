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
    
    internal let presenter : ContactsPresenter = ContactsPresenter(service: ContactsService())
    internal var contactsList = [String:[Contact]]()
    internal var wordsSection = [String]()
    
    //MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewSetup()
        tableViewSetup()
        addingNavBarButtons()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheme), name: NSNotification.Name(Constants.kThemeChanged), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.attachView(self)
        presenter.getContacts()
    }

    // MARK: NOT removing the observer otherwise Darkmode doesn't works, Also If Added in viewWillAppear, then can be removed. Leaving it for now.
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(Constants.kThemeChanged), object: nil)
//    }
}

// MARK: Fileprivate methods

fileprivate extension ContactsViewController {
    
    func mainViewSetup(){
        title = "Contacts"
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3144376874, green: 0.8898145556, blue: 0.7598797679, alpha: 1)
    }
    
    func tableViewSetup(){
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib(nibName: Constants.kContactsCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactsCell)
    }
    
    func addingNavBarButtons(){
        let rightButton = UIBarButtonItem.init( barButtonSystemItem: .add, target: self, action: #selector(addButton))
        
        let leftButton = UIBarButtonItem.init( title: "Groups", style: .plain, target: nil, action: nil)
        
        let darkMode = UIBarButtonItem.init( title: "🛸", style: .plain, target: self, action: #selector(toggleDarkMode))
        navigationItem.rightBarButtonItems = [rightButton,darkMode]
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func addButton(){
        let contactEditVC = ContactEditViewController()
        contactEditVC.contactType = .Add
        let navController = UINavigationController(rootViewController: contactEditVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @objc func toggleDarkMode(){
        let theme = ThemeManager.current()
        if theme == .Dark {
            ThemeManager.applyTheme(theme: .Light)
        }else{
            ThemeManager.applyTheme(theme: .Dark)
        }
        NotificationCenter.default.post(name: NSNotification.Name(Constants.kThemeChanged), object: nil)
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
}

extension ContactsViewController : ContactsView {
    
    func startLoading() {
        super.showLoading()
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    func set(contacts: [String : [Contact]], with sections: [String]) {
        self.contactsList = contacts
        self.wordsSection = sections
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func setEmptyContacts() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
