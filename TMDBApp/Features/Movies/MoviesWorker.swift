//
//  MoviesViewWorker.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol MoviesViewWorkerProtocol {
    func fetchMoviewsView(completion: @escaping (MoviesViewModels.FetchMoviewsView.Response)-> Void)
}
class RemoteWorker: MoviesViewWorkerProtocol {
    func fetchMoviewsView(completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        ApiConfig().apiManager?.getMovies { movies in
            completion(movies)
        } onError: { error in
            
        }

    }
}

class LocalWorker: MoviesViewWorkerProtocol {
    func fetchMoviewsView(completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        
    }
}

class MoviesViewWorker : MoviesViewWorkerProtocol {
    var remoteMovies: RemoteWorker?
    var localMovies: LocalWorker?
    var networkManager : NetworkConnection?
    
   
    
    func fetchMoviewsView(completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        NetworkManager().checkInternetConnection { [weak self] connection in
            let load =  connection == true ? self?.remoteMovies?.fetchMoviewsView : self?.localMovies?.fetchMoviewsView
            load!(completion)
        }
        
    }
}


