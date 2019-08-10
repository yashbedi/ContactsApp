//
//  ContactDetailsPresenter.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation


class ContactDetailsPresenter {
    
    // MARK: Private properties
    
    var service : ContactDetailsService
    weak var view : ContactDetailsView?
    
    // MARK: Initialisers
    
    init(service: ContactDetailsService) {
        self.service = service
    }
    
    // MARK: Internal methods
    
    internal func attachView(_ view: ContactDetailsView){
        self.view = view
    }
    
    internal func detachView(){
        self.view = nil
    }
    
    internal func getContact(from id: Int){
        self.view?.startLoading()
        
        service.getContact(from: id) { [weak self] contact in
            self?.view?.stopLoading()
            
            if contact == nil {
                self?.view?.couldNotGetContact()
            }else{
                self?.view?.set(contact: contact!)
            }
        }
    }
    
    internal func deleteContact(with id: Int) {
        self.view?.startLoading()
        
        service.delete(with: id) { [weak self] result in
            self?.view?.stopLoading()
            
            if result == nil {
                self?.view?.couldNotDelete()
            }else{
                self?.view?.deleted()
            }
        }
    }
}
