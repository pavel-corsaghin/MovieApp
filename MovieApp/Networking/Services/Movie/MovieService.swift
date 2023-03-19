//
//  MovieService.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import Foundation
import Combine

protocol MovieServiceProtocol {
    func searchMovies(movie: String, page: Int) -> AnyPublisher<MovieResponse, NetworkError>

}

struct MovieService: MovieServiceProtocol {
    func searchMovies(movie: String, page: Int) -> AnyPublisher<MovieResponse, NetworkError> {
        Network<MovieResponse>().request(MovieEnpoint.movies(movie, page)) { request in
            request.acceptingJSON()
        }
    }
}
