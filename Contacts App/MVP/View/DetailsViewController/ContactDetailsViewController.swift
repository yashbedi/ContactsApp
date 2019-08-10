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
    internal var presenter : ContactDetailsPresenter = ContactDetailsPresenter(service: ContactDetailsService())
    
    // MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        addRightButton()
        presenter.attachView(self)
        guard let id = contact?.id else { return }
        presenter.getContact(from: id)
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
        let rightButton = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(editButton))
        navigationItem.rightBarButtonItem = rightButton
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
    func edited(contact: Contact) {
        self.contact = contact
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}


extension ContactDetailsViewController : ContactDetailsView {
    
    func set(contact: Contact) {
        self.contact = contact
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func deleted() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func startLoading() {
        super.showLoading()
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    func setEmptyView() {
    }
}
