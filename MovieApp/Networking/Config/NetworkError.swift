//
//  NetworkError.swift
//  MovieApp
//
//  Created by HungNguyen on 2023/03/19.
//

import Foundation

struct ServerErrorData: Equatable {
    let status: HttpStatus
    let message: String?
}

enum NetworkError: Error, Equatable {
    case custom(_ message: String)
    case server(_ data: ServerErrorData)
    case invalidRequest
    case invalidResponse
}

extension NetworkError {
    var description: String {
        switch self {
        case .custom(let message):
            return message
        case .server(let data):
            return data.message ?? data.status.description
        case .invalidRequest:
            return "Invalid request"
        case .invalidResponse:
            return "Invalid response"
        }
    }
}
