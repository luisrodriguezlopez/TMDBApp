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

class MoviesViewViewController: UIViewController {

    // MARK: - Constants

    private enum LocalConstants {

    }
    
    // MARK: - Public Properties

    var interactor: MoviesViewBusinessLogic?
    var router: (MoviesViewRoutingLogic & MoviesViewDataPassing)?

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
        let viewController = self
        let interactor = MoviesViewInteractor()
        let presenter = MoviesViewPresenter()
        let router = MoviesViewRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupVIPCycle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupVIPCycle()
    }

    // MARK: - View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAccessibilityIdentifers()
        performRequest()
    }

    // MARK: - Private Methods

    private func setupUI() {
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

extension MoviesViewViewController: MoviesViewDisplayLogic {
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.ViewModel) {
    }
}
