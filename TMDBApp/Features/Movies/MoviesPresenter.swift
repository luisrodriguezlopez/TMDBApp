//
//  MoviesViewPresenter.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MoviesViewPresentationLogic {
    func presentMoviewsView(response: MoviesViewModels.FetchMoviewsView.Response)
}

class MoviesViewPresenter: MoviesViewPresentationLogic {

    // MARK: - Constants

    private enum LocalConstants {
        enum InitialData {
            // TODO: (Example line. Remove this before start coding) 
            // static let title = "MaintenanceViewController.headTitle".localized
        }
    }
    
    // MARK: - Public Properties

    weak var viewController: MoviesViewDisplayLogic?

    // MARK: - Private Properties

    // MARK: - Initialization

    // MARK: - Private Methods

    // MARK: - MoviesViewPresentationLogic

    func presentMoviewsView(response: MoviesViewModels.FetchMoviewsView.Response) {
        viewController?.displayMoviewsView(viewModel: response)
    }
}
