//
//  MoviesViewRouter.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MoviesViewRoutingLogic {
    func routeToExampleDetail(movie: Movie)
}

protocol MoviesViewDataPassing {
    var dataStore: MoviesViewDataStore? { get }
}

class MoviesViewRouter: MoviesViewRoutingLogic, MoviesViewDataPassing {
    
    // MARK: - Properties

    weak var viewController: MoviesViewController?
    var dataStore: MoviesViewDataStore?

    // MARK: - MoviesViewRoutingLogic

    func routeToExampleDetail(movie: Movie) {
        let detail = DetailViewController()
        detail.viewModel = movie
         viewController?.present(detail, animated: true)
         
    }

    // MARK: - Helpers

    /*
     private func passDataToExampleDetail(source: MoviesViewDataStore, destination: inout ExampleDetailDataStore) {
     destination.menuOptions = source.menuOptions
     }
     */
}

