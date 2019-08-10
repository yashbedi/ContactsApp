//
//  EditServiceMock.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

@testable import Contacts_App

class ContactAddAndEditServiceMock : ContactEditService {
    
    var status : String?
    var contact : Contact?
    
    init(status: String?, contact: Contact?) {
        self.status = status
        self.contact = contact
    }
    
    override func addContact(with params: [String:Any], callBack: @escaping _strBlock){
        callBack(self.status)
    }
    override func editContact(for id: Int, with params: [String:Any], callBack: @escaping _contact) {
        callBack(self.contact)
    }
}


