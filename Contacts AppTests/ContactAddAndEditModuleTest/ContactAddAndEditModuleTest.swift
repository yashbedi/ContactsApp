//
//  ContactAddAndEditModuleTest.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import XCTest
@testable import Contacts_App

class ContactAddAndEditModuleTest: XCTestCase {

    
    // MARK: For Add and Edit Contact Module
    
    let emptyContactAddServiceMock = ContactAddAndEditServiceMock(status: nil, contact: nil)
    var contactAddServiceMock = ContactAddAndEditServiceMock(status: Constants.kSuccess, contact: Contact())
    
    let emptyEditContactServiceMock = ContactAddAndEditServiceMock(status: nil, contact: nil)
    var contactEditServiceMock = ContactAddAndEditServiceMock(status: Constants.kSuccess, contact: Contact())
    
    
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testShouldSetAddContact(){
        let viewMock = ContactAddAndEditViewMock()
        let presenterUnderTest = ContactsEditPresenter(service: contactAddServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        let contact : [String:Any] = ["first_name" : "Yash",
                                      "last_name" : "Yash",
                                      "profile_pic" : "",
                                      "email" : "yash@bedi.com",
                                      "phone_number" : "9812456780",
                                      "created_at" : "13 jul 1992",
                                      "updated_at" : "13 jul 2019",
                                      "favourite" : "true"
        ]
        
        presenterUnderTest.addContact(with: contact)
        
        XCTAssertTrue(viewMock.setSavedContactCalled)
    }
    
    func testShouldSetAddEmptyContact(){
        let viewMock = ContactAddAndEditViewMock()
        let presenterUnderTest = ContactsEditPresenter(service: emptyContactAddServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        let contact : [String:Any] = ["":""]
        
        presenterUnderTest.addContact(with: contact)
        
        XCTAssertTrue(viewMock.setEmptySavedContactCalled)
    }
    
    
    func testShouldSetEditContact(){
        let viewMock = ContactAddAndEditViewMock()
        let presenterUnderTest = ContactsEditPresenter(service: contactEditServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        let contact : [String:Any] = ["first_name" : "Yash",
                                      "last_name" : "Yash",
                                      "profile_pic" : "",
                                      "email" : "yash@bedi.com",
                                      "phone_number" : "9812456780",
                                      "created_at" : "13 jul 1992",
                                      "updated_at" : "13 jul 2019",
                                      "favourite" : "true"
        ]
        
        presenterUnderTest.edit(contact: contact, for: 8992)
        
        XCTAssertTrue(viewMock.setEditContactCalled)
    }
    
    func testShouldSetEditEmptyContact(){
        let viewMock = ContactAddAndEditViewMock()
        let presenterUnderTest = ContactsEditPresenter(service: emptyEditContactServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        let contact : [String:Any] = ["":""]
        
        presenterUnderTest.edit(contact: contact, for: 0)
        
        XCTAssertTrue(viewMock.setEmptyEditContactCalled)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
