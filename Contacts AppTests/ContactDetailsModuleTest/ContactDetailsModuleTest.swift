//
//  ContactDetailsModuleTest.swift
//  Contacts AppTests
//
//  Created by Yash Bedi on 10/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import XCTest
@testable import Contacts_App

class ContactDetailsModuleTest: XCTestCase {

    // MARK: For Fetching Details of a Contact Module
    
    let emptyContactDetailServiceMock = ContactDetailsServiceMock(status: nil, contact: nil)
    var contactDetailServiceMock = ContactDetailsServiceMock(status: Constants.kSuccess, contact: Contact())
    
    let emptyDeleteContactServiceMock = ContactDetailsServiceMock(status: nil, contact: nil)
    var contactDeleteServiceMock = ContactDetailsServiceMock(status: Constants.kSuccess, contact: Contact())
    func testShouldGetDetailContact(){
        let viewMock = ContactDetailsViewMock()
        let presenterUnderTest = ContactDetailsPresenter(service: contactDetailServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        presenterUnderTest.getContact(from: 8992)
        
        XCTAssertTrue(viewMock.getDetailContactCalled )
    }
    
    func testShouldGetDetailEmptyContact(){
        let viewMock = ContactDetailsViewMock()
        let presenterUnderTest = ContactDetailsPresenter(service: emptyContactDetailServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        presenterUnderTest.getContact(from: 0)
        
        XCTAssertTrue(viewMock.getEmptyDetailContactCalled )
    }
    
    
    func testShouldDeleteContact(){
        let viewMock = ContactDetailsViewMock()
        let presenterUnderTest = ContactDetailsPresenter(service: contactDeleteServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        presenterUnderTest.deleteContact(with: 8992)
        
        XCTAssertTrue(viewMock.deleteDetailContactCalled )
    }
    
    func testShouldDeleteEmptyContact(){
        let viewMock = ContactDetailsViewMock()
        let presenterUnderTest = ContactDetailsPresenter(service: emptyDeleteContactServiceMock)
        presenterUnderTest.attachView(viewMock)
        
        presenterUnderTest.deleteContact(with: 8992)
        
        XCTAssertTrue(viewMock.deleteEmptyDetailContactCalled)
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
