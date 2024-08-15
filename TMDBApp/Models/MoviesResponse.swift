//
//  MoviesResponse.swift
//  TMDBApp
//
//  Created by luis rodriguez on 14/08/24.
//

import Foundation
struct MovieResponse : Decodable {
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


extension Decodable {
    func loadJson<T: Decodable>(fileName: String, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        guard
            let url = Bundle.main.url(forResource: fileName, withExtension: ".json"),
            let data = try? Data(contentsOf: url),
            let decodedObject = try? decoder.decode(T.self, from: data)
        else {
            return nil
        }
        
        return decodedObject
    }
}
