//
//  ContactsModuleTest.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import XCTest
@testable import Contacts_App

class ContactsModuleTest: XCTestCase {

    // MARK: For Fetching Contacts Module
    
    let emptyContactsServiceMock = ContactServiceMock(contacts: [Contact]())
    var twoContactsServiceMock = ContactServiceMock(contacts: [Contact]())
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    
    func testShouldSetContact() {
        let contact1 : [String:Any] = ["first_name" : "Yash",
                                       "last_name" : "Yash",
                                       "profile_pic" : "",
                                       "email" : "yash@bedi.com",
                                       "phone_number" : "9812456780",
                                       "created_at" : "13 jul 1992",
                                       "updated_at" : "13 jul 2019",
                                       "favourite" : "true"
        ]
        
        let contact2 : [String:Any] = ["first_name" : "Bedi",
                                       "last_name" : "Bedi",
                                       "profile_pic" : "",
                                       "email" : "bedi@yash.com",
                                       "phone_number" : "9812456780",
                                       "created_at" : "31 jul 1992",
                                       "updated_at" : "31 jul 2019",
                                       "favourite" : "true"
        ]
        
        self.twoContactsServiceMock = ContactServiceMock(contacts: [Contact(from: contact1),Contact(from: contact2)])
        
        //given
        let viewMock = ContactViewMock()
        let presenterUnderTest = ContactsPresenter(service: self.twoContactsServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        //when
        presenterUnderTest.getContacts()
        
        //verify
        XCTAssertTrue(viewMock.setContactsCalled)
    }
    
    func testShouldSetEmptyIfNoContact() {
        //given
        let viewMock = ContactViewMock()
        let contactPresenterUnderTest = ContactsPresenter(service: self.emptyContactsServiceMock)
        contactPresenterUnderTest.attachView(viewMock)
        
        //when
        contactPresenterUnderTest.getContacts()
        
        //verify
        XCTAssertTrue(viewMock.setEmptyContactsCalled)
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
