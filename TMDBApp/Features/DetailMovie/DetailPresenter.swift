//
//  DetailPresenter.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 17/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
    func presentDetail(response: DetailModels.FetchDetail.Response)
}

class DetailPresenter: DetailPresentationLogic {

    // MARK: - Constants

    private enum LocalConstants {
        enum InitialData {
            // TODO: (Example line. Remove this before start coding) 
            // static let title = "MaintenanceViewController.headTitle".localized
        }
    }
    
    // MARK: - Public Properties

    weak var viewController: DetailDisplayLogic?

    // MARK: - Private Properties

    // MARK: - Initialization

    // MARK: - Private Methods

    // MARK: - DetailPresentationLogic

    func presentDetail(response: DetailModels.FetchDetail.Response) {
        let viewModel = DetailModels.FetchDetail.ViewModel()
        viewController?.displayDetail(viewModel: viewModel)
    }
}
