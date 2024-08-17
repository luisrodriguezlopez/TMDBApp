//
//  MoviesViewViewController.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MoviesViewDisplayLogic: AnyObject {
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.ViewModel)
}

class MoviesViewController: UIViewController {

    // MARK: - Constants

    private enum LocalConstants {

    }
    
    // MARK: - Public Properties

    var interactor: MoviesViewBusinessLogic?
    var router: (MoviesViewRoutingLogic & MoviesViewDataPassing)?
    var remoteWorker : RemoteWorker?
    var localWorker: LocalWorker?
    var worker: MoviesViewWorker?
    // MARK: - Private Properties

    // MARK: - Main Views

    /* TODO: REMOVE EXAMPLE
        private let scrollView: UIScrollView = {
            let scrollView = UIScrollView()
            scrollView.bounces = true
            scrollView.alwaysBounceVertical = true
            scrollView.showsHorizontalScrollIndicator = false
            return scrollView
        }()
    */

    // MARK: Content Views

    /*  TODO: REMOVE EXAMPLE
        fileprivate let accessStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.alignment = .fill
            return stackView
        }()
    */

    // MARK: - Initialization

    private func setupVIPCycle() {
     //   let viewController = self
        guard let worker = self.worker else {
             print("Error: Worker es nil.")
             return
         }
        let interactor = MoviesViewInteractor()
      
        let presenter = MoviesViewPresenter()
        let router = MoviesViewRouter()
        self.router = router
        interactor.presenter = presenter
        
        presenter.viewController = self
        interactor.worker = self.worker
        self.interactor = interactor

        router.viewController = self
        router.dataStore = interactor
    }
  

    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIPCycle()
        setupUI()
        setupAccessibilityIdentifers()
        performRequest()
    }

    // MARK: - Private Methods

    private func setupUI() {
       // self.view.backgroundColor = .white
    }

    private func setupAccessibilityIdentifers() {
    }

    // MARK: - Private Methods - Helpers

    private func performRequest() {
        let request = MoviesViewModels.FetchMoviewsView.Request()
        interactor?.fetchMoviewsView(request: request)
    }
}

// MARK: - MoviesViewDisplayLogic

extension MoviesViewController: MoviesViewDisplayLogic {
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.ViewModel) {
        print(viewModel)
    }
}
