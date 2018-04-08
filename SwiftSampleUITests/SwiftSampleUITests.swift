//
//  SwiftSampleUITests.swift
//  SwiftSampleUITests
//
//  Created by Chris Song on 03/04/2018.
//  Copyright © 2018 ChrisMJSong. All rights reserved.
//

import XCTest

class SwiftSampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        snapshot("00_LaunchScreen")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.swipeDown()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["#Swift, #JSON"]/*[[".cells.staticTexts[\"#Swift, #JSON\"]",".staticTexts[\"#Swift, #JSON\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let marketPriceNavigationBar = app.navigationBars["Market Price"]
        marketPriceNavigationBar.buttons["Edit"].tap()
        marketPriceNavigationBar.buttons["Done"].tap()
        marketPriceNavigationBar.buttons["Refresh"].tap()
        app.buttons["END OF TOUR"].tap()
        
    }
    
}
