//
//  ContactDetailsView.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

protocol ContactDetailsView : NSObjectProtocol, BaseView {
    func set(contact: Contact)
    func deleted()
    func couldNotGetContact()
    func couldNotDelete()
}

extension ContactDetailsView {
    func set(contact: Contact) { }
    func deleted() { }
    func couldNotGetContact() { }
    func couldNotDelete() { }
}

