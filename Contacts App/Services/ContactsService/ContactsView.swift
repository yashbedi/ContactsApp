//
//  ContactsView.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

protocol ContactsView : NSObjectProtocol, BaseView {
    func set(contacts : [String:[Contact]], with sections: [String])
    func setEmptyContacts()
}

extension ContactsView{
    func set(contacts : [String:[Contact]], with sections: [String]) { }
    func setEmptyContacts() { }
}
