//
//  DoubleFormatTest.swift
//  finchiosTests
//
//  Created by Brett Fazio on 3/30/21.
//

import XCTest
import finchios

class DoubleFormatTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBasic() throws {
        
        let fivehundred = 500.0
        
        XCTAssert(fivehundred.format() == "500.00", "\(fivehundred.format()) did not equal 500.00")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testComma() throws {
        
        let thousands = 45555.55
        
        XCTAssert(thousands.format() == "45,555.55", "\(thousands.format()) did not equal 45,555.55")
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
