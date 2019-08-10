//
//  ContactDetailsViewMock.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

@testable import Contacts_App

class ContactDetailsViewMock : NSObject, ContactDetailsView {
    
    var getDetailContactCalled = false
    var getEmptyDetailContactCalled = false
    
    var deleteDetailContactCalled = false
    var deleteEmptyDetailContactCalled = false
    
    func set(contact: Contact) {
        getDetailContactCalled = true
    }
    func deleted() {
        deleteDetailContactCalled = true
    }
    func couldNotGetContact() {
        getEmptyDetailContactCalled = true
    }
    func couldNotDelete() {
        deleteEmptyDetailContactCalled = true
    }
}
