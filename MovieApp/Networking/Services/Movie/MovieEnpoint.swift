//
//  MovieEnpoint.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import Foundation

enum MovieEnpoint {
    case movies(_ movie: String,_ page: Int)
}

extension MovieEnpoint: EndpointConvertible {
    var path: String {
        switch self {
        case .movies:
            return ""
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .movies:
            return .get
        }
    }

    var httpBody: Data? {
        switch self {
        case .movies:
            return nil
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .movies:
            return [:]
        }
    }

    var queryItems: [String : String]? {
        switch self {
        case .movies(let movie, let page):
            return [
                "apikey": NetworkConfig.apiKey,
                "type": "movie",
                "s": movie,
                "page": String(page)
            ]
        }
    }
}
