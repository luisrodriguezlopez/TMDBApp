//
//  DataLoader.swift
//  TMDBApp
//
//  Created by luis rodriguez on 15/08/24.
//

import Foundation

protocol DataLoader {
    func loader(completion: @escaping (MovieResponse)-> Void)
}

class RemoteLoader: DataLoader {
    func loader(completion: @escaping (MovieResponse) -> Void) {
        ApiConfig().apiManager?.getMovies { movies in
            completion(movies)
        } onError: { error in
            
        }

    }
}

class LocalLoader: DataLoader {
    func loader(completion: @escaping (MovieResponse) -> Void) {
        
    }
}

class RemoteWithLocalFallBackDataLoader : DataLoader {
    let remoteMovies: RemoteLoader
    let localMovies: LocalLoader
    
    init(remoteMovies: RemoteLoader, localMovies: LocalLoader) {
        self.remoteMovies = remoteMovies
        self.localMovies = localMovies
    }
    
    func loader(completion: @escaping (MovieResponse) -> Void) {
        NetworkManager().checkInternetConnection { [weak self] connection in
            let load =  connection == true ? self?.remoteMovies.loader : self?.localMovies.loader
            load!(completion)
        }
        
    }
    
    
}
