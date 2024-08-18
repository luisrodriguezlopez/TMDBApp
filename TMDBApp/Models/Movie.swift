//
//  Movies.swift
//  TMDBApp
//
//  Created by luis rodriguez on 14/08/24.
//
import ui_core
import Foundation
struct Movie  : Decodable , MovieDisplayable {
    var id : Int?
    var title : String?
    var override : String?
    var poster_path : String?
    var backdrop_path : String?
    var release_date : String?
    var original_language : String?
    var vote_average : Double?

    enum CodingKeys: String, CodingKey {
           case id , title , overview , poster_path , backdrop_path, release_date, original_language , vote_average
    }
    public init(from decoder: Decoder) throws {
        do {
        let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            override = try container.decode(String.self, forKey: .overview)
            poster_path = try container.decode(String.self, forKey: .poster_path)
            backdrop_path = try container.decode(String.self, forKey: .backdrop_path)
            release_date = try container.decode(String.self, forKey: .release_date)
            original_language = try container.decode(String.self, forKey: .original_language)
            vote_average = try container.decode(Double.self, forKey: .vote_average)

        } catch {
            print(error.localizedDescription)
        }
    
    }
}
