//
//  ContactEditView.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

protocol ContactEditView : NSObjectProtocol, BaseView {
    func savedContact()
    func edited(contact: Contact)
    func couldNotSavedContact()
    func couldNotEditContact()
}

extension ContactEditView{
    func savedContact() {}
    func edited(contact: Contact) {}
    func couldNotSavedContact() {}
    func couldNotEditContact() {}
}
