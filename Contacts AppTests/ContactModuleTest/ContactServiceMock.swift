//
//  ContactServiceMock.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

@testable import Contacts_App

class ContactServiceMock : ContactsService {
    
    private var contacts : [Contact]
    
    init(contacts: [Contact]) {
        self.contacts = contacts
    }
    
    override func getContacts(_ callBack: @escaping _contacts) {
        callBack(self.contacts)
    }
}

