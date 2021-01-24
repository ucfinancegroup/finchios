//
//  GoalEditViewModelTest.swift
//  finchiosTests
//
//  Created by Brett Fazio on 1/23/21.
//

import XCTest
import finchios
import OpenAPIClient

class GoalEditViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWrongDate() throws {
        let model = GoalEditViewModel()
        
        model.start = Date(timeIntervalSince1970: 100000)
        model.end = Date(timeIntervalSince1970: 100000)
        
        XCTAssert(model.getPayload() == nil)
        
        model.end = Date(timeIntervalSince1970: 100000-1)
        
        XCTAssert(model.getPayload() == nil)
    }
    
    func testEdit() throws {
        let model = GoalEditViewModel()
        
        model.start = Date(timeIntervalSince1970: 5)
        model.end = Date(timeIntervalSince1970: 7)
        model.name = "Dave"
        // What the user entered
        model.threshold = "500"
        
        let payload = model.getPayload()
        
        XCTAssert(payload != nil)
        
        let unwrap = payload!
        
        XCTAssert(unwrap.name == model.name)
        XCTAssert(unwrap.start == 5)
        XCTAssert(unwrap.end == 7)
        // unwrap.threshold should contain 50000
        XCTAssert(unwrap.threshold/100 == Double(model.threshold))
        
    }
    
    func testSet() throws {
        let model = GoalEditViewModel()
        
        model.set(goal: GoalAndStatus.dummy)
        
        // Make sure fields are set properly
        let dummy = GoalAndStatus.dummy.goal
        
        
        XCTAssert(model.name == dummy.name)
        
        XCTAssert(Int64(model.start.timeIntervalSince1970) == dummy.start)
        
        XCTAssert(Int64(model.end.timeIntervalSince1970) == dummy.end)
        
        XCTAssert(Double(model.threshold)!*100 == dummy.threshold)
    }

}
