//
//  ContactDetailsService.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation


class ContactDetailsService {
    
    func getContact(from id: Int, callBack: @escaping _contact) {
        let url = URL(string: "\(Constants.kBaseUrl)/contacts/\(id).json")!
        NetworkManager.shared.get(from: url) { response in
            guard let _response = response else { callBack(nil); return}
            
            do {
                if let object = try JSONSerialization.jsonObject(with: _response) as? Dictionary<String,  Any>{
                    let contact = Contact(from: object)
                    callBack(contact)
                }
            }catch let e {
                print(e.localizedDescription)
                callBack(nil)
            }
        }
    }
    
    func delete(with id: Int, callBack: @escaping _strBlock){
        NetworkManager.shared.deleteContact(with: id) { result in
            guard let _result = result else { callBack(nil); return }
            
            if _result.compare(Constants.kSuccess) == ComparisonResult.orderedSame {
                callBack(_result)
            }else {
                callBack(nil)
            }
        }
    }
}
