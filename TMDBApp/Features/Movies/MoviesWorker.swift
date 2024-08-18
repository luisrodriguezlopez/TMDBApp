//
//  MoviesViewWorker.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
import Services
import Foundation
protocol MoviesViewWorkerProtocol {
    func fetchMoviewsView(list:ListType,page:Int,completion: @escaping (MoviesViewModels.FetchMoviewsView.Response)-> Void)
}
class RemoteWorker: MoviesViewWorkerProtocol {
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    let base_url = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    let version = Bundle.main.infoDictionary?["API_VERSION"] as? String ?? ""
    
    
    func fetchMoviewsView(list:ListType,page: Int,completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        ApiConfig(url: base_url, method: "GET", token: apiKey, version: version).apiManager?.fetchData(page:page, listType: list) { movies in
            completion(movies)
        } onError: { error in
            
        }

    }
}

class LocalWorker: MoviesViewWorkerProtocol {
    func fetchMoviewsView(list:ListType,page: Int,completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        
    }
}

class MoviesViewWorker : MoviesViewWorkerProtocol {
    var remoteMovies: RemoteWorker?
    var localMovies: LocalWorker?
    var networkManager : NetworkConnection?
    
   
    
    func fetchMoviewsView(list:ListType,page: Int,completion: @escaping (MoviesViewModels.FetchMoviewsView.Response) -> Void) {
        NetworkManager().checkInternetConnection { [weak self] connection in
            let load =  connection == true ? self?.remoteMovies?.fetchMoviewsView(list: list,page:page ,completion:completion) : self?.localMovies?.fetchMoviewsView(list: list,page:page ,completion:completion)
            
        }
        
    }
}


