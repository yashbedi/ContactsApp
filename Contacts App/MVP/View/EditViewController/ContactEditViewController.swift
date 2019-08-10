//
//  ContactEditViewController.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactEditViewController: BaseViewController {
    
    // MARK: Public properties
    
    internal var contact = Contact()
    internal weak var delegate: ContactDelegate?
    internal var contactType : ContactType = .none
    internal let presenter : ContactsEditPresenter = ContactsEditPresenter(service: ContactEditService())
    
    // MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        tableViewSetup()
        addingNavBarButtons()
        addingTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterNotifications()
    }
}


fileprivate extension ContactEditViewController {
    
    func tableViewSetup(){
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.keyboardDismissMode = .onDrag
        
        tableView?.register(UINib(nibName: Constants.kContactInfoCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactInfoCell)
        tableView?.register(UINib(nibName: Constants.kAddProfilePictureCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kAddProfilePictureCell)
    }
    
    func addingNavBarButtons(){
        let rightButton = UIBarButtonItem.init(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButton)
        )
        
        let leftButton = UIBarButtonItem.init(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(cancelButton)
        )
        
        navigationItem.rightBarButtonItem = rightButton
        navigationItem.leftBarButtonItem = leftButton
    }
    
    func addingTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    @objc func cancelButton(){
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func validate(_ email: String, and mobile: String){
        if mobile.isValidPhone {
            contact.mobile = mobile
        }else{
            showAlert(with: Constants.kValid , and: Constants.kValidPhone)
            return
        }
        if email.isValidEmail {
            contact.email = email
        }else{
            showAlert(with: Constants.kValid, and: Constants.kValidEmail)
            return
        }
    }
    
    func postContactToBackend(){
        
        switch contactType {
        case .Add:
            contact.favourite = true
            presenter.addContact(with: contact.toDictionary())
        case .Edit:
            guard let id = contact.id else{
                showAlert(with: Constants.kErrorTitle, and: Constants.kSomethingWent)
                cancelButton()
                return
            }
            presenter.edit(contact: contact.toDictionary(), for: id)
        default: break
        }
    }
    
    @objc func doneButton(){
        
        guard
            let fName = getInfoCell(at: 1).infoField.text, fName.count > 0,
            let lName = getInfoCell(at: 2).infoField.text, lName.count > 0,
            let mobile = getInfoCell(at: 3).infoField.text, mobile.count > 0,
            let email = getInfoCell(at: 4).infoField.text, email.count > 0
            else {
                showAlert(with: Constants.kEmptyFields, and: Constants.kFieldsCantBeBlank)
                return
        }
        contact.firstName = fName
        contact.lastName = lName
        validate(email, and: mobile)
        postContactToBackend()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 40, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        tableView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}


extension ContactEditViewController : ContactEditView{
    
    func savedContact() {
        cancelButton()
    }
    
    func edited(contact: Contact) {
        delegate?.edited(contact: contact)
        cancelButton()
    }
    
    func startLoading() {
        super.showLoading()
    }
    
    func stopLoading() {
        super.hideLoading()
    }
    
    func couldNotEditContact() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func couldNotSavedContact() {
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
}
