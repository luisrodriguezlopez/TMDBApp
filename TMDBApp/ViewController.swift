//
//  ViewController.swift
//  TMDBApp
//
//  Created by luis rodriguez on 14/08/24.
//

import UIKit

class ViewController: UIViewController {
    var loader : DataLoader!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.loader { responseMovies in
            print(responseMovies)
        }

        // Do any additional setup after loading the view.
    }


}

