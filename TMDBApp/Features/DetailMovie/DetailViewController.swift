//
//  DetailViewController.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 17/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailDisplayLogic: AnyObject {
    func displayDetail(viewModel: DetailModels.FetchDetail.ViewModel)
}
/*

 Genres
 Popularity
 Languages
 Vote average
 */
class DetailViewController: UIViewController {

    // MARK: - Constants

    private enum LocalConstants {

    }
    var viewModel : Movie?
    
    private var imageView : UIImageView = {
      let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 8
        return image
    }()
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold, width: .standard)
        return label
    }()
    
    private var overrideLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private var overrideTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Override"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold, width: .standard)
        return label
    }()
    
    private var releaseDate : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold, width: .standard)
        return label
    }()
    
    private var language : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium, width: .standard)
        label.backgroundColor = .white
        label.tintColor = .blue
        label.textAlignment = .center
    
        return label
    }()
    
    private var languageIcon : UIImageView = {
      let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.image = UIImage(systemName: "globe.americas.fill")
        image.backgroundColor = .white
        image.tintColor = .blue
        
        return image
    }()
    
    private var voteAvergeLbl : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Override"
        label.font = UIFont.systemFont(ofSize: 54, weight: .bold, width: .standard)
        return label
    }()
    
    
    private var voteIcon : UIImageView = {
      let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = .systemYellow
        
        return image
    }()
    
    private var stack : UIStackView = {
       var stackView = UIStackView()
       stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = false
     //   stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        return stackView
    }()
    
    // MARK: - Public Properties

    var interactor: DetailBusinessLogic?
    var router: (DetailRoutingLogic & DetailDataPassing)?

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
        let interactor = DetailInteractor()
        let presenter = DetailPresenter()
        let router = DetailRouter()
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
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.overrideTitle)
        self.view.addSubview(self.overrideLabel)
        self.view.addSubview(self.releaseDate)
        self.view.addSubview(self.language)
        self.view.addSubview(self.languageIcon)
      
        self.view.addSubview(self.stack)
        self.stack.addArrangedSubview(voteAvergeLbl)
        self.stack.addArrangedSubview(voteIcon)
        
        self.view.backgroundColor = .darkText
        self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 32).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true

        self.releaseDate.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: -16).isActive = true
        self.releaseDate.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
       // self.releaseDate.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true

        
        self.overrideTitle.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4).isActive = true
        self.overrideTitle.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        self.overrideTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true

        
        self.overrideLabel.topAnchor.constraint(equalTo: self.overrideTitle.bottomAnchor, constant: 4).isActive = true
        self.overrideLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        self.overrideLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
     
        self.language.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.language.widthAnchor.constraint(equalToConstant: 25).isActive = true

        self.languageIcon.topAnchor.constraint(equalTo: self.overrideTitle.bottomAnchor, constant: -50).isActive = true
        self.languageIcon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true

        self.languageIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.languageIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        self.language.topAnchor.constraint(equalTo: self.overrideTitle.bottomAnchor, constant: -25).isActive = true
        self.language.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true

       
        
        
      
        self.stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.stack.topAnchor.constraint(equalTo: self.overrideLabel.bottomAnchor, constant: 15).isActive = true
      //  self.stack.heightAnchor.constraint(equalToConstant: 200).isActive = true
      //  self.stack.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.voteIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.voteIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
    //    self.voteIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

       // self.voteIcon.topAnchor.constraint(equalTo: self.voteAvergeLbl.bottomAnchor, constant: 10).isActive = true

        
        
        self.titleLabel.text = self.viewModel?.title ?? ""
        self.imageView.loadImage(from:  "https://image.tmdb.org/t/p/original/\(self.viewModel?.backdrop_path ?? "" )")
        self.overrideLabel.text = self.viewModel?.override ?? ""
        self.releaseDate.text = self.viewModel?.release_date ?? ""
        self.language.text = self.viewModel?.original_language ?? ""
        self.language.text = self.language.text?.uppercased()
        let formattedVoteAverage = String(format: "%.1f", self.viewModel?.vote_average ?? 0)
        self.voteAvergeLbl.text = formattedVoteAverage
    }
    private func setupAccessibilityIdentifers() {
    }

    // MARK: - Private Methods - Helpers

    private func performRequest() {
        let request = DetailModels.FetchDetail.Request()
        interactor?.fetchDetail(request: request)
    }
}

// MARK: - DetailDisplayLogic

extension DetailViewController: DetailDisplayLogic {
    func displayDetail(viewModel: DetailModels.FetchDetail.ViewModel) {
    }
}
