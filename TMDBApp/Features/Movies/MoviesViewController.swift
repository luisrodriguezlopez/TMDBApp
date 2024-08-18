//
//  MoviesViewViewController.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import ui_core


protocol MoviesViewDisplayLogic: AnyObject {
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.Response)
}

class MoviesViewController: UIViewController {
    // MARK: - UICollectionViewDelegateFlowLayout

     var customGird: CustomCollectionView<MovieDisplayable> = {
         var grid = CustomCollectionView<MovieDisplayable>()
         grid.translatesAutoresizingMaskIntoConstraints = false
         grid.backgroundColor = UIColor(named: "")
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
    
    
    var buttonDarkMode : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "moon.circle"), for: .normal)
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
        button.backgroundColor = UIColor(named: "fontColor")
        button.layer.borderColor = UIColor(named: "background")?.cgColor
     //   button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor(named: "background"), for: .normal)

        return button
    }()
    
    var buttonNowPlaying : UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("🔥Now Playing🎬", for: .normal)
        button.backgroundColor = UIColor(named: "background")
        button.layer.borderColor = UIColor(named: "fontColor")?.cgColor
     //   button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.setTitleColor(UIColor(named: "fontColor"), for: .normal)
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
      
        self.view.backgroundColor = UIColor(named: "background")
        self.view.addSubview(buttonLayaout)
        self.view.addSubview(buttonPopular)
        self.view.addSubview(buttonNowPlaying)
        buttonLayaout.addTarget(self, action: #selector(changeLayaout), for: .touchUpInside)
        buttonPopular.addTarget(self, action: #selector(popularMovies), for: .touchUpInside)
        buttonNowPlaying.addTarget(self, action: #selector(nowPlaying), for: .touchUpInside)
        buttonDarkMode.addTarget(self, action: #selector(changeDarkMode), for: .touchUpInside)

        self.customGird.pagination = self
        self.customGird.selectDelegate = self
        self.view.addSubview(customGird)
        self.view.addSubview(buttonDarkMode)

 

        
        customGird.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        customGird.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 60).isActive = true
        customGird.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        customGird.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        customGird.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        buttonLayaout.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonLayaout.widthAnchor.constraint(equalToConstant: 42).isActive = true
        buttonLayaout.bottomAnchor.constraint(equalTo: self.customGird.topAnchor, constant: -8).isActive = true
        buttonLayaout.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant:
        -16).isActive = true
        
        buttonDarkMode.heightAnchor.constraint(equalToConstant: 42).isActive = true
        buttonDarkMode.widthAnchor.constraint(equalToConstant: 42).isActive = true
        buttonDarkMode.bottomAnchor.constraint(equalTo: self.customGird.bottomAnchor, constant: -8).isActive = true
        buttonDarkMode.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant:
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
        self.buttonPopular.setTitleColor(UIColor(named: "background"), for: .normal)
        self.buttonPopular.backgroundColor = UIColor(named: "fontColor")
        self.buttonNowPlaying.setTitleColor(UIColor(named: "fontColor"), for: .normal)
        self.buttonNowPlaying.backgroundColor = UIColor(named: "background")
        self.interactor?.fetchMoviewsView(type: .popular)
    }
    
    @objc func nowPlaying() {
        self.isPopularSearch = false 
        self.buttonNowPlaying.setTitleColor(UIColor(named: "background"), for: .normal)
        self.buttonNowPlaying.backgroundColor = UIColor(named: "fontColor")
        self.buttonPopular.setTitleColor(UIColor(named: "fontColor"), for: .normal)
        self.buttonPopular.backgroundColor = UIColor(named: "background")
        self.interactor?.fetchMoviewsView(type: .now_playing)
    }
    
    @objc func changeDarkMode() {
        let darkMode = UserDefaults.standard.bool(forKey: "darkModeEnable")
        let appdelegate = UIApplication.shared.windows.first
        appdelegate?.overrideUserInterfaceStyle =  darkMode ? .dark : .light
        UserDefaults.standard.set(!darkMode, forKey: "darkModeEnable")

    }
    
}

// MARK: - MoviesViewDisplayLogic

extension MoviesViewController: MoviesViewDisplayLogic {
    func displayMoviewsView(viewModel: MoviesViewModels.FetchMoviewsView.Response) {
        guard let movies = viewModel.movies else {
            return
        }
       
        DispatchQueue.main.async { [weak self] in
            self?.customGird.config(data:  movies, list: self?.isPopularSearch == true ? .popular : .nowPlaying )
        }
    }
}

extension MoviesViewController: paginationDelegate {
    func fetchPage() {
        interactor?.fetchMoviewsView(type: .popular)

    }
}
extension MoviesViewController : movieCellDelegate {
    func select(movie: MovieDisplayable) {
        router?.routeToExampleDetail(movie: movie)
    }
}

