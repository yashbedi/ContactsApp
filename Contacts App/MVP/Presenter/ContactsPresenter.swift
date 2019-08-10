//
//  ContactsPresenter.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

class ContactsPresenter {
    
    // MARK: Private Properties
    
    private let service : ContactsService
    weak private var view : ContactsView?
    
    // MARK: Initialisers
    
    init(service: ContactsService) {
        self.service = service
    }
    
    // MARK: Internal methods
    
    internal func attachView(_ view: ContactsView){
        self.view = view
    }

    internal func detachView(){
        self.view = nil
    }
    
    internal func getContacts() {
        self.view?.startLoading()
        
        service.getContacts { [weak self] contacts in
            self?.view?.stopLoading()
            if contacts == nil || contacts?.count == 0 {
                self?.view?.setEmptyContacts()
            }else{
                var contactsList = [String: [Contact]]()
                var wordsSection = [String]()
                
                for contact in contacts! {
                    if let firstName = contact.firstName {
                        
                        // Taking out the first letter from name's, to create sectionList from available names.
                        let sectionKey = "\(firstName[(firstName.startIndex)])".uppercased()
                        
                        // CHECK: Not to store redundant keys. Keys must be unique
                        
                        // If key exists
                        if var contactAssociatedToKey = contactsList[sectionKey] {
                            
                            // Append contact object to contact Array.
                            contactAssociatedToKey.append(contact)
                            
                            // And insert contact object to its associated key.
                            contactsList[sectionKey] = contactAssociatedToKey
                        }else{
                            
                            // If key doesn't exists then write the key to array and insert associated contact object
                            contactsList[sectionKey] = [contact]
                        }
                    }
                }
                // Initialising wordSection array from string keys and sorting them afterwards.
                wordsSection = [String](contactsList.keys).sorted()
                
                self?.view?.set(contacts: contactsList, with: wordsSection)
            }
        }
    }
}
