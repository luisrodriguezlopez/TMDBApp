//
//  MoviesViewTestCase.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 16/08/24.
//

import XCTest
@testable import TMDBApp
@testable import ui_core
final class MoviesViewTestCase: XCTestCase {
    let sut = MoviesViewController()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testInitMoviesGrdView() {
        let collectionView = sut.customGird
        sut.viewDidAppear(true)
        XCTAssertNotNil(collectionView)
      

    }
    
    func testCollectionViewConfig() {
        let grid = sut.customGird
         sut.viewDidAppear(true)
        XCTAssertNotNil(grid.collectionView)
        XCTAssertNotNil(grid.collectionView.numberOfSections == 0)
        XCTAssertNil(grid.collectionView.cellForItem(at: IndexPath(index: 0)))
    }
    
    
    func testModelTest() {
        let collectionView = sut.customGird
         sut.viewDidAppear(true)
        sut.viewDidLoad()
        
        collectionView.frame = sut.view.frame
        //sut.collectionView.register(MoviewCollectionViewCell.self,
        //                            forCellWithReuseIdentifier: "moviesCell")
        sut.customGird.moviesModelPopular = MoviesViewModels.FetchMoviewsView.Response().loadJson(fileName: "movies", type: MoviesViewModels.FetchMoviewsView.Response.self)!.movies!;
        XCTAssertTrue( sut.customGird.moviesModelPopular.count > 0)
       
    }
    
}
