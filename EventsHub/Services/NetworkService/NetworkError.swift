//
//  NetworkError.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//

import Foundation

struct ErrorResponse: Decodable {
    let error: String
}

enum NetworkError: Error {
    case invalidResponse
    case decodingFailed
    case clientError(Int, message: String?)
    case serverError(Int, message: String?)
    case unknownError(Int)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .clientError(_, let message),
             .serverError(_, let message):
            return message ?? "Something went wrong."
        case .invalidResponse:
            return "Invalid response from server."
        case .decodingFailed:
            return "Failed to process response."
        case .unknownError:
            return "Unexpected error occurred."
        }
    }
}
