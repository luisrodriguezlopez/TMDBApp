//
//  MovieViewCell.swift
//  TMDBApp
//
//  Created by luis rodriguez on 17/08/24.
//


import UIKit
class MoviewCollectionViewCell: UICollectionViewCell {
    
    private var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
   
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Movie) {
        self.imageView.loadImage(from: "https://image.tmdb.org/t/p/original/\(data.poster_path ?? "")")
    }
    
    private func addSubviews() {
        self.addSubview(imageView)
    }
    
    private func addConstraints() {
        addConstraintsForImageView()
    }
    
    private func addConstraintsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        self.backgroundColor = .black
       // imageView.clipsToBounds = true
       // imageView.layer.cornerRadius = 40
    }
    

}
