//
//  MovieResponse.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import Foundation

struct MovieResponse: Decodable {
    let totalResults: Int
    let movies: [Movie]
    let error: String?
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case error = "Error"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movies = try container.decodeIfPresent([Movie].self, forKey: .movies) ?? []
        if let totalResults = try container.decodeIfPresent(String.self, forKey: .totalResults) {
            self.totalResults = Int(totalResults) ?? 0
        } else {
            self.totalResults = 0
        }
        error = try container.decodeIfPresent(String.self, forKey: .error)
    }
}

struct Movie: Decodable {
    let title: String
    let year: String
    let imdbId: String
    let poster: String
    
    private enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
}
