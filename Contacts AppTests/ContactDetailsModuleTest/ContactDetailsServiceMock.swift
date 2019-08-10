//
//  ContactDetailsServiceMock.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

@testable import Contacts_App

class ContactDetailsServiceMock : ContactDetailsService {
    
    var status : String?
    var contact : Contact?
    
    init(status: String?, contact: Contact?) {
        self.status = status
        self.contact = contact
    }
    
    override func getContact(from id: Int, callBack: @escaping _contact) {
        callBack(self.contact)
    }
    override func delete(with id: Int, callBack: @escaping _strBlock){
        callBack(self.status)
    }
}


