//
//  MoviesTestCase.swift
//  TMDBAppTests
//
//  Created by luis rodriguez on 15/08/24.
//

import XCTest
@testable import TMDBApp

final class MoviesViewWorkerTests: XCTestCase {
     var sut: MockMoviesWorker!
      var remoteWorkerMock: RemoteWorkerMock!
      var localWorkerMock: LocalWorkerMock!
      var networkManagerMock: NetworkManagerMock!
    
    
    override func setUp() {
          super.setUp()
          remoteWorkerMock = RemoteWorkerMock()
          localWorkerMock = LocalWorkerMock()
          networkManagerMock = NetworkManagerMock()
          sut = MockMoviesWorker()
        sut.remoteMovies = remoteWorkerMock
        sut.localMovies = localWorkerMock
        sut.networkManager = networkManagerMock
      }

      override func tearDown() {
          sut = nil
          remoteWorkerMock = nil
          localWorkerMock = nil
          networkManagerMock = nil
          super.tearDown()
      }
    
    

      func testFetchMoviesView_WhenConnectedToInternet_DoesNotCallLocalWorker() {
          // Arrange
          networkManagerMock.isConnectedToInternet = true

          // Act
          sut.fetchMoviewsView(list: .now_playing, page: 1) { _ in }

          // Assert
          XCTAssertFalse(localWorkerMock.fetchMoviesViewCalled)
      }

      func testFetchMoviesView_WhenNotConnectedToInternet_DoesNotCallRemoteWorker() {
          // Arrange
          networkManagerMock.isConnectedToInternet = false

          // Act
          sut.fetchMoviewsView(list: .now_playing, page: 1) { _ in }

          // Assert
          XCTAssertFalse(remoteWorkerMock.fetchMoviesViewCalled)
      }
    
    func testCollectionView() {
        
        
    }
    
  }

  class RemoteWorkerMock: RemoteWorker {
      var fetchMoviesViewCalled = false

      override func fetchMoviewsView(list:ListType,page: Int,completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {

          fetchMoviesViewCalled = true
          if let movieResponse: MoviesViewModels.FetchMoviewsView.Response = MoviesViewModels.FetchMoviewsView.Response().loadJson(fileName: "movies", type: MoviesViewModels.FetchMoviewsView.Response.self) {
              completion(movieResponse)
              
          }
      }
  }

class LocalWorkerMock: LocalWorker {
    var fetchMoviesViewCalled = false
    
    override func fetchMoviewsView(list:ListType,page: Int,completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        fetchMoviesViewCalled = true
        if let movieResponse: MoviesViewModels.FetchMoviewsView.Response = MoviesViewModels.FetchMoviewsView.Response().loadJson(fileName: "movies", type: MoviesViewModels.FetchMoviewsView.Response.self) {
            completion(movieResponse)
        }
    }
}
    
    class NetworkManagerMock: NetworkManager {
        var isConnectedToInternet: Bool = false
        
        override func checkInternetConnection(completion: @escaping (Bool) -> Void) {
            completion(isConnectedToInternet)
        }
    }
    
    
    
    
    
    class RemoteLoaderMock: MoviesViewWorkerProtocol {
        
        func fetchMoviewsView(list: TMDBApp.ListType, page: Int, completion: @escaping (TMDBApp.MoviesViewModels.FetchMoviewsView.Response) -> Void) {
            if let movieResponse: MoviesViewModels.FetchMoviewsView.Response = MoviesViewModels.FetchMoviewsView.Response().loadJson(fileName: "movies", type: MoviesViewModels.FetchMoviewsView.Response.self) {
                completion(movieResponse)
            }else {
                print("error")
            }
        }
        
    }
    
class LocalLoaderMock: MoviesViewWorkerProtocol {
    
    
    func fetchMoviewsView(list: TMDBApp.ListType, page: Int, completion: @escaping (TMDBApp.MoviesViewModels.FetchMoviewsView.Response) -> Void) {
            if let movieResponse: MoviesViewModels.FetchMoviewsView.Response = MoviesViewModels.FetchMoviewsView.Response().loadJson(fileName: "movies", type: MoviesViewModels.FetchMoviewsView.Response.self) {
                completion(movieResponse)
            }else {
                print("error")
            }
        }
        
    }


class MoviesViewControllerTests: XCTestCase {
    
    var sut: MoviesViewController!
    var interactorMock: MoviesViewInteractorMock!
    var routerMock: MoviesViewRouterMock!
    var remoteWorkerMock: RemoteWorkerMock!
    var localWorkerMock: LocalWorkerMock!
    var worker: MockMoviesWorker?
    
    override func setUp() {
        super.setUp()
        interactorMock = MoviesViewInteractorMock()
        routerMock = MoviesViewRouterMock()
        remoteWorkerMock = RemoteWorkerMock()
        localWorkerMock = LocalWorkerMock()
        worker = MockMoviesWorker()
        sut = MoviesViewController()
        sut.interactor = interactorMock
        sut.router = routerMock
        sut.remoteWorker = remoteWorkerMock
        sut.localWorker = localWorkerMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        routerMock = nil
        remoteWorkerMock = nil
        localWorkerMock = nil
        super.tearDown()
    }
   
     
    class MoviesViewInteractorMock: MoviesViewInteractor {
        var fetchMoviesViewCalled = false
        
        override func fetchMoviewsView(type: ListType) {
            fetchMoviesViewCalled = true
        }
    }
    
    class MoviesViewRouterMock: MoviesViewRouter {
    }
    
}
