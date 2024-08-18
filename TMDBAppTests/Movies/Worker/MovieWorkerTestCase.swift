//
//  MovieWorkerTestCase.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 16/08/24.
//

import XCTest
@testable import TMDBApp
@testable import Helpers

final class MovieWorkerTestCase: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
     func testRemoteWorker() {
         let sut = MockMoviesWorker()
         sut.localMovies = LocalWorker()
         sut.remoteMovies = RemoteWorker()
         var countMovies = 0
         let expectation = self.expectation(description:
         "return list of movies")
         
         sut.networkManager = MockNetworkManager()
         
         sut.fetchMoviewsView(list: .now_playing, page: 1) { response in
             countMovies = response.movies?.count ?? 0
             expectation.fulfill()
         }
         waitForExpectations(timeout: 5.0, handler: nil) //3
         XCTAssertEqual(countMovies, 20)
     }
     
    
     func testLocalWorker() {
        //arrange
        let mockWorker = MockMoviesWorker()
        // sut.loader = LocalLoaderMock()
        //act
        var countMovies = 0
        let expectationList = self.expectation(description:
                                            "return list of mockmovies")
         mockWorker.networkManager = MockNetworkManager()

         mockWorker.fetchMoviewsView(list: .now_playing, page: 1) { movieResponse in
            countMovies = movieResponse.movies?.count ?? 0
            expectationList.fulfill()
        }
        
        waitForExpectations(timeout: 5.0, handler: nil) //3
        XCTAssertEqual(countMovies, 20)
    }
    
    

    

}


class MockMoviesWorker : MoviesViewWorkerProtocol {
    var remoteMovies: RemoteWorker?
    var localMovies: LocalWorker?
    var networkManager : NetworkConnection?
    
    func fetchMoviewsView(list: TMDBApp.ListType, page: Int, completion: @escaping (TMDBApp.MoviesViewModels.FetchMoviewsView.Response) -> Void) {
         networkManager?.checkInternetConnection(completion: { response in
             if let movieResponse: MoviesViewModels.FetchMoviewsView.Response = MoviesViewModels.FetchMoviewsView.Response().loadJson(fileName: "movies", type: MoviesViewModels.FetchMoviewsView.Response.self) {
                 
             
                 completion(movieResponse)

                 
             }else {
                 print("error")
             }
        })
       
    }
}
