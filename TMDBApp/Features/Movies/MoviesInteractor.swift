//
//  MoviesViewInteractor.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

enum ListType: String  {
    case popular = "popular"
    case now_playing = "now_playing"
}

protocol MoviesViewBusinessLogic {
    func fetchMoviewsView(type: ListType)
}

protocol MoviesViewDataStore {

}

class MoviesViewInteractor: MoviesViewBusinessLogic, MoviesViewDataStore {
    
    // MARK: - Constants
    var pageCont = 0
    private enum LocalConstants {
    }

    // MARK: - Public Properties

    var presenter: MoviesViewPresentationLogic?
    var worker : MoviesViewWorker?
    // MARK: - Data Store

    // MARK: - Private Properties

    // MARK: - Initialization

    // MARK: - Private Methods

    // MARK: - Network calls

    // MARK: - MoviesViewBusinessLogic

    func fetchMoviewsView(type: ListType) {
        pageCont += 1
        // Perform network requests here and present afterwards
        self.worker?.fetchMoviewsView(list: type, page: pageCont) { response in
            self.presenter?.presentMoviewsView(response: response)

        }
    }
}
