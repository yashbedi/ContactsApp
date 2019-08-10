//
//  EditViewMock.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation
@testable import Contacts_App

class ContactAddAndEditViewMock : NSObject, ContactEditView {
    
    var setSavedContactCalled = false
    var setEmptySavedContactCalled = false
    
    var setEditContactCalled = false
    var setEmptyEditContactCalled = false
    
    
    func savedContact() {
        setSavedContactCalled = true
    }
    
    func edited(contact: Contact) {
        setEditContactCalled = true
    }
    
    func couldNotSavedContact() {
        setEmptySavedContactCalled = true
    }
    
    func couldNotEditContact() {
        setEmptyEditContactCalled = true
    }
}
