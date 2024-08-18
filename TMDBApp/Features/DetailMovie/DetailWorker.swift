//
//  DetailWorker.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 17/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol DetailWorkerProtocol {
    func fetchDetail(request: DetailModels.FetchDetail.Request)
}

class DetailWorker: DetailWorkerProtocol {

    // MARK: - Constants

    // MARK: - Private properties

    // MARK: - Initialization
    
    // MARK: - DetailWorkerProtocol

    func fetchDetail(request: DetailModels.FetchDetail.Request) {
    }
}
