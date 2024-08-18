//
//  DetailInteractor.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 17/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol DetailBusinessLogic {
    func fetchDetail(request: DetailModels.FetchDetail.Request)
}

protocol DetailDataStore {

}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    
    // MARK: - Constants

    private enum LocalConstants {
    }

    // MARK: - Public Properties

    var presenter: DetailPresentationLogic?
    var worker: DetailWorkerProtocol = DetailWorker()

    // MARK: - Data Store

    // MARK: - Private Properties

    // MARK: - Initialization

    // MARK: - Private Methods

    // MARK: - Network calls

    // MARK: - DetailBusinessLogic

    func fetchDetail(request: DetailModels.FetchDetail.Request) {
        // Perform network requests here and present afterwards
        let response = DetailModels.FetchDetail.Response()
        presenter?.presentDetail(response: response)
    }
}
