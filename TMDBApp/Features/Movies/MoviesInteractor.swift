//
//  MoviesViewInteractor.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol MoviesViewBusinessLogic {
    func fetchMoviewsView(request: MoviesViewModels.FetchMoviewsView.Request)
}

protocol MoviesViewDataStore {

}

class MoviesViewInteractor: MoviesViewBusinessLogic, MoviesViewDataStore {
    
    // MARK: - Constants

    private enum LocalConstants {
    }

    // MARK: - Public Properties

    var presenter: MoviesViewPresentationLogic?
    var worker: MoviesViewWorkerProtocol = MoviesViewWorker()

    // MARK: - Data Store

    // MARK: - Private Properties

    // MARK: - Initialization

    // MARK: - Private Methods

    // MARK: - Network calls

    // MARK: - MoviesViewBusinessLogic

    func fetchMoviewsView(request: MoviesViewModels.FetchMoviewsView.Request) {
        // Perform network requests here and present afterwards
        let response = MoviesViewModels.FetchMoviewsView.Response()
        presenter?.presentMoviewsView(response: response)
    }
}
