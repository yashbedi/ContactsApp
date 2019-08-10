//
//  ContactExtras.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

public enum ContactType {
    case Edit
    case Add
    case none
}

public protocol ContactDelegate : class {
    func edited(contact: Contact)
}

public enum CellType {
    case fName
    case lName
    case mobile
    case email
    case none
}


public enum http : String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}


typealias _block = ([Dictionary<String,Any>]?) -> Void
typealias _contacts = ([Contact]?) -> Void
typealias _contact = (Contact?) -> Void
typealias _dataBlock = (Data?) -> Void
typealias _strBlock = (String?) -> Void

