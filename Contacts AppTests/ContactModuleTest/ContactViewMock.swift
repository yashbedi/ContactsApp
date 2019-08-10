//
//  ContactViewMock.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

@testable import Contacts_App

class ContactViewMock : NSObject, ContactsView {
    
    var setContactsCalled = false
    var setEmptyContactsCalled = false
    
    func set(contacts : [String:[Contact]], with sections: [String]) {
        setContactsCalled = true
    }
    
    func setEmptyContacts(){
        setEmptyContactsCalled = true
    }
}
