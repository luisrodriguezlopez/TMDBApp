//
//  DetailRouter.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 17/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailRoutingLogic {
    func routeToExampleDetail()
}

protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get }
}

class DetailRouter: DetailRoutingLogic, DetailDataPassing {
    
    // MARK: - Properties

    weak var viewController: DetailViewController?
    var dataStore: DetailDataStore?

    // MARK: - DetailRoutingLogic

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
     private func passDataToExampleDetail(source: DetailDataStore, destination: inout ExampleDetailDataStore) {
     destination.menuOptions = source.menuOptions
     }
     */
}

