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
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.Response)
}

class MoviesViewController: UIViewController {
    // MARK: - UICollectionViewDelegateFlowLayout

     var customGird: CustomCollectionView = {
         var grid = CustomCollectionView(frame: .zero)
         grid.translatesAutoresizingMaskIntoConstraints = false
         return grid
      }()
    
    var buttonLayaout : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "circle.grid.2x2"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.cornerRadius = 22
        return button
    }()
    
    var buttonPopular : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("🔥Most Popular 🎬", for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setTitleColor(.black, for: .normal)

        return button
    }()
    
    var buttonNowPlaying : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("🔥Now Playing🎬", for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    
    
    // MARK: - Constants

    private enum LocalConstants {

    }
    private var isGrid = false
    private var isPopularSearch = true
    
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupVIPCycle()
        setupAccessibilityIdentifers()
        performRequest()
    }

    // MARK: - Private Methods

    private func setupUI() {
        
        self.view.addSubview(buttonLayaout)
        self.view.addSubview(buttonPopular)
        self.view.addSubview(buttonNowPlaying)
        buttonLayaout.addTarget(self, action: #selector(changeLayaout), for: .touchUpInside)
        buttonPopular.addTarget(self, action: #selector(popularMovies), for: .touchUpInside)
        buttonNowPlaying.addTarget(self, action: #selector(nowPlaying), for: .touchUpInside)

        self.customGird.pagination = self
        self.customGird.selectDelegate = self
        self.view.addSubview(customGird)
        
 

        
        customGird.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        customGird.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        customGird.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        customGird.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonLayaout.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonLayaout.widthAnchor.constraint(equalToConstant: 42).isActive = true
        buttonLayaout.bottomAnchor.constraint(equalTo: self.customGird.topAnchor, constant: -8).isActive = true
        buttonLayaout.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant:
        -16).isActive = true
        
        buttonPopular.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonPopular.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonPopular.bottomAnchor.constraint(equalTo: self.customGird.topAnchor, constant: -8).isActive = true
        buttonPopular.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant:
        16).isActive = true
        buttonPopular.trailingAnchor.constraint(equalTo: self.buttonNowPlaying.leadingAnchor,constant:
        -8).isActive = true
        buttonNowPlaying.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonNowPlaying.widthAnchor.constraint(equalToConstant: 150).isActive = true
        buttonNowPlaying.bottomAnchor.constraint(equalTo: self.customGird.topAnchor, constant: -8).isActive = true

        customGird.layoutIfNeeded()
    }

    private func setupAccessibilityIdentifers() {
    }

    // MARK: - Private Methods - Helpers

    private func performRequest() {
        interactor?.fetchMoviewsView(type: .now_playing)
    }
    
    @objc func changeLayaout() {
        self.isGrid = !self.isGrid
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            
            self.customGird.collectionView.collectionViewLayout = self.isGrid ?
            self.customGird.configGrid() : self.customGird.configLayaout()
            
            self.customGird.collectionView.reloadData()
        })
    }
    
    @objc func popularMovies() {
        self.isPopularSearch = true
        self.buttonPopular.setTitleColor(.black, for: .normal)
        self.buttonPopular.backgroundColor = .white
        self.buttonNowPlaying.setTitleColor(.white, for: .normal)
        self.buttonNowPlaying.backgroundColor = .clear
        self.interactor?.fetchMoviewsView(type: .popular)
    }
    
    @objc func nowPlaying() {
        self.isPopularSearch = false 
        self.buttonNowPlaying.setTitleColor(.black, for: .normal)
        self.buttonNowPlaying.backgroundColor = .white
        self.buttonPopular.setTitleColor(.white, for: .normal)
        self.buttonPopular.backgroundColor = .clear
        self.interactor?.fetchMoviewsView(type: .now_playing)
    }
    
}

// MARK: - MoviesViewDisplayLogic

extension MoviesViewController: MoviesViewDisplayLogic {
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.Response) {
        guard let movies = viewModel.movies else {
            return
        }
       
        DispatchQueue.main.async { [weak self] in
            self?.customGird.config(data:  movies, list: self?.isPopularSearch == true ? .popular : .now_playing )
        }
    }
}

extension MoviesViewController: paginationDelegate {
    func fetchPage() {
        interactor?.fetchMoviewsView(type: .popular)

    }
}
extension MoviesViewController : movieCellDelegate {
    func select(movie: Movie) {
        router?.routeToExampleDetail(movie: movie)
    }
}

