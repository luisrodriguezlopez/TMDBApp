//
//  MoviesViewModels.swift
//  TMDBApp
//
//  team @Team_Name
//  Created by luis rodriguez on 15/08/24.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum MoviesViewModels {
    
    // MARK: Use cases

    enum FetchMoviewsView {
        struct Request {
        }
        
        struct Response: Decodable {
            var page : Int?
            var movies : [Movie]?
            
            enum CodingKeys: String, CodingKey {
                   case movies = "results"
            }
            init() { }
            
            public init(from decoder: Decoder) throws {
                   do {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
                    movies = try container.decode([Movie].self, forKey: .movies)
                   } catch {
                    print(error)
                   }
            }
        }
        
        struct ViewModel {
        }
    }
}
