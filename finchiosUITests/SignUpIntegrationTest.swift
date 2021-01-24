//
//  SignUpIntegrationTest.swift
//  finchiosUITests
//
//  Created by Brett Fazio on 1/23/21.
//

import XCTest

class SignUpIntegrationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBackAndForth() throws {
        let app = XCUIApplication()
        //TODO(): make extension for app to do all this
        app.launchEnvironment = ["key": "val"]
        app.launchArguments = ["UI-Testing"]
        app.launch()
        
        app.buttons["Sign Up"].tap()
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        app.buttons["Already have an account? Log in."].tap()
        
        assert(app.buttons["Sign Up"].isHittable == false)
        
        assert(app.navigationBars.buttons.count > 0)
    }
}
