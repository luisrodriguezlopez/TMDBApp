//
//  MoviesViewWorker.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol MoviesViewWorkerProtocol {
    func fetchMoviewsView(request: MoviesViewModels.FetchMoviewsView.Request)
}

class MoviesViewWorker: MoviesViewWorkerProtocol {

    // MARK: - Constants

    // MARK: - Private properties

    // MARK: - Initialization
    
    // MARK: - MoviesViewWorkerProtocol

    func fetchMoviewsView(request: MoviesViewModels.FetchMoviewsView.Request) {
    }
}
