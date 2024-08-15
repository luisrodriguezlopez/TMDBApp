//
//  Movies.swift
//  TMDBApp
//
//  Created by luis rodriguez on 14/08/24.
//

import Foundation
struct Movie  : Decodable {
    var id : Int?
    var title : String?
    var override : String?
    var poster_path : String?
    var backdrop_path : String?
    enum CodingKeys: String, CodingKey {
           case id , title , overview , poster_path , backdrop_path
    }
    public init(from decoder: Decoder) throws {
        do {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            override = try container.decode(String.self, forKey: .overview)
            poster_path = try container.decode(String.self, forKey: .poster_path)
            backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
        } catch {
            print(error.localizedDescription)
        }
    
    }
}
