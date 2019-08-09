//
//  ContactEditViewController.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

public enum ContactType {
    case Edit
    case Add
    case none
}

protocol ContactDelegate : class {
    func edit(contact: Contact)
}

class ContactEditViewController: BaseViewController {

    internal var contact = Contact()
    internal weak var delegate: ContactDelegate?
    internal var contactType : ContactType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.keyboardDismissMode = .onDrag
        
        tableView?.register(UINib(nibName: Constants.kContactInfoCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kContactInfoCell)
        tableView?.register(UINib(nibName: Constants.kAddProfilePictureCell,
                                  bundle: nil), forCellReuseIdentifier: Constants.kAddProfilePictureCell)
        
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
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3144376874, green: 0.8898145556, blue: 0.7598797679, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyBoard(){
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        registerNotifications()
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unregisterNotifications()
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
        let imageCell = getImageCell()
        let status = imageCell.profileImageView.image?.isEqualToImage(image: UIImage(named:
            Constants.kPictureHolder) ?? UIImage())
        if status ?? false {
            contact.image = nil
        }else{
            contact.image = imageCell.profileImageView.image?.pngData()
        }
        
        switch contactType {
        case .Add:
            contact.favourite = true
            addAndPostContactToBackend(with: contact.toDictionary())
        case .Edit:
            editAndPostContactToBackend()
        default: break
        }
    }
    
    internal func addAndPostContactToBackend(with params: [String : Any]){
        super.showLoading()
        NetworkManager.shared.addContact(with: params) { (result) in
            super.hideLoading()
            if result?.compare(Constants.kSuccess) == ComparisonResult.orderedSame {
                self.cancelButton()
            }else{
                self.showAlert(with: Constants.kErrorTitle, and: Constants.kInternetError)
            }
        }
    }
    
    internal func editAndPostContactToBackend(){
        
        guard let id = contact.id else{
            showAlert(with: Constants.kErrorTitle, and: Constants.kSomethingWent)
            cancelButton()
            return
        }
        super.showLoading()
        NetworkManager.shared.editContact(for: id,
                                          with: contact.toDictionary())
        { (contactObject) in
            super.hideLoading()
            if contactObject != nil{
                self.delegate?.edit(contact: contactObject ?? Contact())
                self.cancelButton()
            }else{
                self.showAlert(with: Constants.kErrorTitle, and: Constants.kInternetError)
            }
        }
    }
    
    @objc func cancelButton(){
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterNotifications() {
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
