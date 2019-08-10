//
//  ContactsEditPresenter.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation


class ContactsEditPresenter {
    
    // MARK: Private properties
    
    var service : ContactEditService
    weak var view : ContactEditView?
    
    // MARK: Initialisers
    
    init(service: ContactEditService) {
        self.service = service
    }
    
    // MARK: Internal methods
    
    internal func attachView(_ view: ContactEditView){
        self.view = view
    }
    
    internal func detachView(){
        self.view = nil
    }
    
    internal func addContact(with params: [String: Any]){
        self.view?.startLoading()
        
        service.addContact(with: params) { [weak self] result in
            self?.view?.stopLoading()
            if result == nil {
                self?.view?.couldNotSavedContact()
            }else{
                self?.view?.savedContact()
            }
        }
    }
    
    internal func edit(contact: [String: Any], for id: Int ){
        self.view?.startLoading()
        
        service.editContact(for: id, with: contact) {[weak self]  contact in
            self?.view?.stopLoading()
            if contact == nil {
                self?.view?.couldNotEditContact()
            }else{
                self?.view?.edited(contact: contact!)
            }
        }
    }
}
