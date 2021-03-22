//
//  NewEventModelTest.swift
//  finchiosTests
//
//  Created by Brett Fazio on 3/21/21.
//

import XCTest
import finchios
import OpenAPIClient

class NewEventModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDateValid() throws {
        
        let model = NewEventModel()
        
        model.start = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 5000)
        
        XCTAssert(model.dateValid())
        
    }
    
    func testDateInvald() throws {
        let model = NewEventModel()
        
        model.start = Date(timeIntervalSince1970: Date().timeIntervalSince1970 - 5000)
        
        XCTAssert(model.dateValid() == false)
        
    }
    
    func testSet() throws {
        
        let model = NewEventModel()
        
        model.setSelected(event: .dummy)
        
        XCTAssert(model.event.id!.oid == Event.dummy.id!.oid)
        
    }
}
