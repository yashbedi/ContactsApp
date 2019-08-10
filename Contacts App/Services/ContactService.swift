//
//  ContactsService.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

struct ContactsService {
    
    internal func getContacts(_ callBack: @escaping _contacts) {
        
        NetworkManager.shared.get { response in
        
            guard let arrayOfObjects = response else { callBack(nil); return }
            
            let contacts = arrayOfObjects.map { return Contact(from: $0) }
            
            callBack(contacts)
        }
    }
}
