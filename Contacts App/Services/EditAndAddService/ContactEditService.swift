//
//  ContactEditService.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

class ContactEditService {
    
    func addContact(with params: [String:Any], callBack: @escaping _strBlock){
        
        NetworkManager.shared.addContact(with: params) { result in
            guard let _result = result else { callBack(nil); return }
            
            if _result.compare(Constants.kSuccess) == ComparisonResult.orderedSame {
                callBack(_result)
            }else {
                callBack(nil)
            }
        }
    }
    
    func editContact(for id: Int, with params: [String:Any], callBack: @escaping _contact) {
        
        NetworkManager.shared.editContact(for: id, with: params) { contact in
            
            guard let _contact = contact else { callBack(nil); return}

            callBack(_contact)
        }
    }
}

