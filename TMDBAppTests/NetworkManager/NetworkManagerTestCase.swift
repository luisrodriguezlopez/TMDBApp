//
//  NetworkManagerTestCase.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 16/08/24.
//

import XCTest
@testable import TMDBApp
final class NetworkManagerTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNoInternetConnectionState() {
        let sut = MockNetworkManager()
        sut.connection = false
        let expectation = expectation(description: "No internet connection")
        sut.checkInternetConnection { response in
            expectation.fulfill()
            XCTAssertFalse(response)

        }
        waitForExpectations(timeout: 2.0, handler: nil) //3
        XCTAssertFalse(sut.connection)
        
    }
    
    func testInternetConnectionState() {
        let sut = MockNetworkManager()
        sut.connection = true
        let expectation = expectation(description: "No internet connection")
        sut.checkInternetConnection { response in
            expectation.fulfill()
            XCTAssertTrue(response)

        }
        waitForExpectations(timeout: 2.0, handler: nil) //3
        XCTAssertTrue(sut.connection)
        
    }

}


class MockNetworkManager : NetworkConnection {

    var connection : Bool = false

    func checkInternetConnection(completion: @escaping (Bool) -> Void) {
        completion(connection)
    }
}
