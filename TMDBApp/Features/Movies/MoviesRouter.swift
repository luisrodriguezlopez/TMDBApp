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
    func routeToExampleDetail()
}

protocol MoviesViewDataPassing {
    var dataStore: MoviesViewDataStore? { get }
}

class MoviesViewRouter: MoviesViewRoutingLogic, MoviesViewDataPassing {
    
    // MARK: - Properties

    weak var viewController: MoviesViewViewController?
    var dataStore: MoviesViewDataStore?

    // MARK: - MoviesViewRoutingLogic

    func routeToExampleDetail() {
        /*
         let exampleDetailViewController = ExampleDetailViewController()

         if var destination = menuOptionsViewController.router?.dataStore, let source = self.dataStore {
            self.passDataToExampleDetail(source: source, destination: &destination)
         }
         viewController?.present(exampleDetailViewController, animated: true)
         */
    }

    // MARK: - Helpers

    /*
     private func passDataToExampleDetail(source: MoviesViewDataStore, destination: inout ExampleDetailDataStore) {
     destination.menuOptions = source.menuOptions
     }
     */
}

