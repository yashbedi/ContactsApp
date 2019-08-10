//
//  ContactsService.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation


class ContactsService {
    
    internal func getContacts(_ callBack: @escaping _contacts) {
        let url = URL(string: "\(Constants.kBaseUrl)/contacts.json")!
        NetworkManager.shared.get(from: url) { response in
            
            guard let _response = response else { callBack(nil); return }
            
            do {
                if let arrayOfObjects = try JSONSerialization.jsonObject(with: _response) as? [Dictionary<String,  Any>]{
                    let contacts = arrayOfObjects.map { return Contact(from: $0) }
                    callBack(contacts)
                }
            }catch let e {
                print(e.localizedDescription)
                callBack(nil)
            }
        }
    }
}
