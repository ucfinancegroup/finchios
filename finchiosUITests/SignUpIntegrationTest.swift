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
        //XCUIApplication().launch()

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
    
    func testFlowSuccessWithoutAccountCreation() throws {
        let app = XCUIApplication()
        //TODO(): make extension for app to do all this
        app.launchEnvironment = ["key": "val"]
        app.launchArguments = ["UI-Testing"]
        app.launch()
        
        app.children(matching: .window).element(boundBy: 1).children(matching: .other).element.tap()
        app.textFields["First Name"].tap()
        
        let deleteKey = app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards.keys[\"delete\"]",".keys[\"delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        deleteKey.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        bKey.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        eKey.tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        tKey.tap()
        tKey.tap()
        app.textFields["Last Name"].tap()
        deleteKey.tap()
        deleteKey.tap()
        deleteKey.tap()
        
        let fKey = app/*@START_MENU_TOKEN@*/.keys["f"]/*[[".keyboards.keys[\"f\"]",".keys[\"f\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        fKey.tap()
        fKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Continue"].tap()

        //TODO() Finish
                
    }
}
