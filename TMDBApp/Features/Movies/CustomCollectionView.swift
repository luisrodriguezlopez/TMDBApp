//
//  CustomCollectionView.swift
//  TMDBApp
//
//  Created by luis rodriguez on 17/08/24.
//

import UIKit

protocol paginationDelegate {
    func fetchPage()
}
protocol movieCellDelegate {
    func select(movie: Movie)
}
class CustomCollectionView: UIView {
    
    var moviesModelPopular : [Movie] = []
    var moviesModelPlayingNow : [Movie] = []
    var isPopular = true
    var pagination: paginationDelegate?
    var selectDelegate : movieCellDelegate?
    var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.accessibilityLabel = "peliculas"
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isUserInteractionEnabled = true
        // collectionView.alwaysBounceHorizontal = true
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initComponents()
        
    }
    
    
    func initComponents() {
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.prefetchDataSource = self
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        //    self.collectionView.frame = self.frame
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.collectionView.collectionViewLayout = configLayaout()
        self.collectionView.register(MoviewCollectionViewCell.self, forCellWithReuseIdentifier: "moviesCell")
        
        
    }
    
    func config(data: [Movie], list: ListType) {
        switch (list) {
        case .popular :
            isPopular = true
            self.moviesModelPopular = [moviesModelPopular, data].flatMap{$0}
            self.collectionView.reloadData()
            
        default :
            isPopular = false
            self.moviesModelPlayingNow = [moviesModelPlayingNow, data].flatMap{$0}
            self.collectionView.reloadData()
        }
    }
}


extension CustomCollectionView:   UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configGrid() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitem: item, count: 3)
        
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configLayaout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize.init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3)), subitem: item, count: 1)
        
        
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isPopular ? self.moviesModelPopular.count  : self.moviesModelPlayingNow.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell", for: indexPath) as? MoviewCollectionViewCell
        let movie = isPopular ? moviesModelPopular[indexPath.row] :  moviesModelPlayingNow[indexPath.row]
        cell?.configure(data: movie)
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = isPopular ? moviesModelPopular[indexPath.row] :  moviesModelPlayingNow[indexPath.row]
        self.selectDelegate?.select(movie: movie)
    }
    
}
extension CustomCollectionView: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let currentArray = isPopular ? self.moviesModelPopular : self.moviesModelPlayingNow
        if let indexPath = indexPaths.last, indexPath.row >= currentArray.count - 5 {
            self.pagination?.fetchPage()
        }
    }
    
    
}
