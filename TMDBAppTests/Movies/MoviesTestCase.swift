//
//  MoviesTestCase.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 15/08/24.
//

import XCTest
@testable import TMDBApp

final class MoviesTestCase: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testInitialWithLocalLoaderVC() {
        //arrange
        let sut = ViewController()
        sut.loader = LocalLoader()
        sut.loader.loader { movieResponse in
            
        }
        XCTAssertNotNil(sut.loader)
    }
    
    
    func testremoteLoaderVC() {
        //arrange
        let sut = ViewController()
        sut.loader = RemoteLoaderMock()
        
        //act
        var countMovies = 0
        let expectation = self.expectation(description:
        "return list of movies")
        
        sut.loader.loader { movieResponse in
            countMovies = movieResponse.movies?.count ?? 0
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil) //3
        XCTAssertEqual(countMovies, 20)
    }
}


class RemoteLoaderMock: DataLoader {
    
    func loader(completion: @escaping (TMDBApp.MovieResponse) -> Void) {
        if let movieResponse: MovieResponse = MovieResponse().loadJson(fileName: "movies", type: MovieResponse.self) {
           completion(movieResponse)
        }else {
            print("error")
        }
    }
    
    
}
