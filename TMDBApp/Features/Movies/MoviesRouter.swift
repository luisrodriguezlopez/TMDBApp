//
//  MoviesViewRouter.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import ui_core
protocol MoviesViewRoutingLogic {
    func routeToExampleDetail(movie: MovieDisplayable)
}

protocol MoviesViewDataPassing {
    var dataStore: MoviesViewDataStore? { get }
}

class MoviesViewRouter: MoviesViewRoutingLogic, MoviesViewDataPassing {
    
    // MARK: - Properties

    weak var viewController: MoviesViewController?
    var dataStore: MoviesViewDataStore?

    // MARK: - MoviesViewRoutingLogic

    func routeToExampleDetail(movie: MovieDisplayable) {
        var detail = DetailViewController()
        detail.viewModel = movie as! Movie
         viewController?.present(detail, animated: true)
         
    }

    // MARK: - Helpers

    /*
     private func passDataToExampleDetail(source: MoviesViewDataStore, destination: inout ExampleDetailDataStore) {
     destination.menuOptions = source.menuOptions
     }
     */
}

