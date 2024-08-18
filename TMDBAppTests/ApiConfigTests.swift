//
//  ApiConfigTests.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 14/08/24.
//

import XCTest

final class ApiConfigTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiKeyConfig() {
        let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
        XCTAssertTrue(apiKey != "")
        XCTAssertNotNil(apiKey)
        
    }

}
