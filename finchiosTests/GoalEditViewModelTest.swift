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
