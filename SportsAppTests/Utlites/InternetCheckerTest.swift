//
//  InternetCheckerTest.swift
//  SportsAppTests
//
//  Created by Rafeef Esam on 11/05/2023.
//

import XCTest
import Reachability
@testable import SportsApp
final class InternetCheckerTest: XCTestCase {

    override func setUpWithError() throws {
   
    }

    override func tearDownWithError() throws {
        
    }
    
    func testIsInternetAvailable() {
       let expectation = XCTestExpectation(description: "Internet availability expectation")
       let isAvailable = InternetCheker.isInternetAvailable()
       if isAvailable {
           XCTAssertTrue(isAvailable, "Internet should be available")
           expectation.fulfill()
       } else {
           XCTAssertFalse(isAvailable, "Internet should be unavailable")
           expectation.fulfill()
       }
           
       wait(for: [expectation], timeout: 5.0)
   }

}
